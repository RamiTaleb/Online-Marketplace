class Resolvers::RestockProduct < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID
  argument :quantity, !types.Int

  description 'Restock a product by a given quantity to make sure
  its available for purchase'

  # return type from the mutation
  type Types::ProductType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    # Here we are just finding the respective product and adding the value of quantity
    # to its inventory_count
    product = Product.find_by(id: args[:id])
    if product
      product.inventory_count += args[:quantity]
      product.save
      Product.find_by(id: args[:id])
    end
  end
end
