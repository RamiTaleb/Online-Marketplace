Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :create_product, Types::ProductType do
    argument :title, !types.String
    argument :price, !types.Float
    argument :inventory_count, !types.Int
    description 'Add a product to the catalogue'

    resolve ->(obj, args, ctx) {
      Product.create(
        title: args[:title],
        price: args[:price],
        inventory_count: args[:inventory_count]
      )
    }
  end
end
