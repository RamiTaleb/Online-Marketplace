Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # This mutation allows you to add a product given the expected arguments (title, price, inventory_count)
  field :create_product, Types::ProductType do
    argument :title, !types.String
    argument :price, !types.Float
    argument :inventory_count, !types.Int
    description 'Add a product to the catalogue. Requires a title (string), price (float) and inventory_count (int)'

    resolve ->(obj, args, ctx) {
      Product.create!(
        title: args[:title],
        price: args[:price],
        inventory_count: args[:inventory_count]
      )
    }
  end

  # This mutation allows you to purchase a product given a product ID if the product is available
  field :purchase_product, Types::ProductType do
    argument :id, !types.ID
    description 'Purchase a product (decreases the inventory count of product by 1 only if the inventory count of the product is > 0)'

    resolve ->(obj, args, ctx) {
      prod = Product.find_by(id: args[:id])
      count = prod.inventory_count
      if count > 0
        count -= 1
        prod.inventory_count = count
        prod.save
      end
      Product.find_by(id: args[:id])
    }
  end

  # This mutation allows you to create an empty cart
  field :create_cart do
    type Types::CartType
    description 'Create an empty cart to begin adding products to'
    resolve ->(obj, args, ctx) {
      cart = Cart.create!(
        order_total: 0,
        order_status: 'In Progress'
      )
    }
  end

  # This mutation allows you to add a product to your cart given a product ID and a cart ID
  field :add_to_cart do
    type Types::CartType
    argument :product_id, !types.ID
    argument :cart_id, !types.ID
    description 'Adds a single product to a specified cart'
    resolve ->(obj, args, ctx) {
      prod = Product.find_by(id: args[:product_id])
      cart = Cart.find_by(id: args[:cart_id])
      item = Item.create!(
        title: prod.title,
        price: prod.price,
        product: prod,
        cart: cart
      )
      cart.order_total += prod.price
      cart.save
      Cart.find_by(id: args[:cart_id])
    }
  end

  # This mutation allows you to checkout a cart. Purchasing all the items
  # within the cart. Must provide a cart ID
  field :checkout_cart, Types::CartType do
    argument :cart_id, !types.ID
    description 'Checkout a cart, purchases all items within cart'
    resolve ->(obj, args, ctx) {
      cart = Cart.find_by(id: args[:cart_id])
      # If the cart has already been checked out then just return the cart without performing any actions
      if cart.order_status == 'In Progress'
        out_of_stock = false
        items = cart.items
        items.each { |item|
          product = item.product
          count = product.inventory_count
          if count > 0
            count -= 1
            product.inventory_count = count
            product.save
          else out_of_stock = true
          end
        }
        cart.order_status = !out_of_stock ? 'Completed' : 'Partially Completed'
        cart.save
      end
      Cart.find_by(id: args[:cart_id])
    }
  end

end
