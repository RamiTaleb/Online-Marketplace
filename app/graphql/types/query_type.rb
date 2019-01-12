Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  # This query finds a product in the catalogue given a product ID
  field :product_by_title do
    type Types::ProductType
    argument :title, !types.String
    description 'Find a product by title'
    resolve ->(obj, args, ctx) {
      Product.find_by(title: args[:title])
    }
  end

  # This query finds a product in the catalogue given a product title
  field :product_by_id do
    type Types::ProductType
    argument :id, !types.ID
    description 'Find a product by ID'
    resolve ->(obj, args, ctx) {
      Product.find_by(id: args[:id])
    }
  end

  # This query finds all products or all available products
  # given an optional argument
  field :all_products do
    type types[Types::ProductType]
    argument :only_available, types.Boolean
    description 'Find all products (optional: find only available products by passing true)'
    resolve ->(obj, args, ctx) {
      # If :only_available is set to true then we only want to return
      # available products
      if args[:only_available] == true
        Product.where('inventory_count > 0')
      else
        Product.all
      end
    }
  end

  # This allows you to view a cart given a cart ID
  field :cart_by_id do
    type Types::CartType
    argument :id, !types.ID
    description 'Find a cart by ID'
    resolve ->(obj, args, ctx) {
      Cart.find_by(id: args[:id])
    }
  end

end