class Resolvers::CheckoutCart < GraphQL::Function
  # arguments passed as "args"
  argument :cart_id, !types.ID

  description 'Checkout a cart, purchases all items within cart'

  # return type from the mutation
  type Types::CartType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    cart = Cart.find_by(id: args[:cart_id])
    # If the cart has already been checked out then just return the cart
    # without performing any actions
    if cart && cart.order_status == 'In Progress'
      # If we see that we tried to purchase an item that is out of stock
      # (inventory_count = 0) then we will only
      # Partially Complete the cart checkout
      out_of_stock = false

      items = cart.items
      # Here we are looping through all the items in a cart to decrement
      # the product's inventory
      # count only if its greater than 0
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
  end
end