class Resolvers::AddToCart < GraphQL::Function
  # arguments passed as "args"
  argument :product_id, !types.ID
  argument :cart_id, !types.ID

  description 'Adds a single product to a specified cart'

  # return type from the mutation
  type Types::CartType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    # Here we are creating an item and associating it to the respective
    # cart and product specified
    prod = Product.find_by(id: args[:product_id])
    cart = Cart.find_by(id: args[:cart_id])
    Item.create!(
      title: prod.title,
      price: prod.price,
      product: prod,
      cart: cart
    )
    cart.order_total += prod.price
    cart.save
    Cart.find_by(id: args[:cart_id])
  end
end