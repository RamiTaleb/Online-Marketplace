class Resolvers::RemoveItemFromCart < GraphQL::Function
  # arguments passed as "args"
  argument :cart_id, !types.ID
  argument :item_id, !types.ID

  description 'Remove a specific item from a specified cart'

  # return type from the mutation
  type Types::CartType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    # Here I am finding the price of the item we are removing so that we can
    # subtract that from the total price of the cart,
    # then updating the cart total
    item = Item.find_by(id: args[:item_id])
    price = item.price

    cart = Cart.find_by(id: args[:cart_id])
    cart.order_total -= price
    item.destroy
    cart.save
    Cart.find_by(id: args[:cart_id])
  end
end