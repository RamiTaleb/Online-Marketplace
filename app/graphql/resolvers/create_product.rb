class Resolvers::CreateProduct < GraphQL::Function
  # arguments passed as "args"
  argument :title, !types.String
  argument :price, !types.Float
  argument :inventory_count, !types.Int
  description 'Add a product to the catalogue. Requires a title (string), price (float) and inventory_count (int)'

  # return type from the mutation
  type Types::ProductType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    Product.create!(
      title: args[:title],
      price: args[:price],
      inventory_count: args[:inventory_count]
    )
  end
end
