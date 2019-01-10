Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :product_by_title do
    type Types::ProductType
    argument :title, !types.String
    description "Find a product by Title"
    resolve ->(obj, args, ctx) {
      Product.find_by(title: args[:title])
    }
  end

  field :all_products do
    type types[Types::ProductType]
    argument :only_available, types.Boolean
    description "Find all products (optional: find only available products)"
    resolve ->(obj, args, ctx) {
      if args[:only_available] == true
        Product.where('inventory_count > 0')
      else
        Product.all
      end
    }
  end

end