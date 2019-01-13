Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  # Product Queries

  field :products do
    type types[Types::ProductType]
    argument :id, types.ID
    argument :title, types.String
    argument :only_available, types.Boolean

    description 'Returns a specific product by id or title, or all available
    products dependent on argument passed.
    If none passed then returns all products.'

    # If :title is passed then return the product with the matched title
    # If :id is passed then return the product with the matched id
    # If :only_available & equal true is passed, return all available products
    # If nothing is passed then return all products
    resolve ->(obj, args, ctx) {
      if args[:id]
        Product.where(id: args[:id])
      elsif args[:title]
        Product.where(title: args[:title])
      elsif args[:only_available] == true
        Product.where('inventory_count > 0')
      else
        Product.all
      end
    }
  end

  # # This query finds a product in the catalogue given a product ID
  # field :product_by_title do
  #   type Types::ProductType
  #   argument :title, !types.String
  #
  #   description 'Find a product by title'
  #
  #   resolve ->(obj, args, ctx) {
  #     Product.find_by(title: args[:title])
  #   }
  # end
  #
  # # This query finds a product in the catalogue given a product title
  # field :product_by_id do
  #   type Types::ProductType
  #   argument :id, !types.ID
  #
  #   description 'Find a product by ID'
  #
  #   resolve ->(obj, args, ctx) {
  #     Product.find_by(id: args[:id])
  #   }
  # end
  #
  # # This query finds all products or all available products
  # # given an optional argument
  # field :all_products do
  #   type types[Types::ProductType]
  #   argument :only_available, types.Boolean
  #
  #   description 'Find all products (optional: find only available products
  #   by passing true)'
  #   resolve ->(obj, args, ctx) {
  #     # If :only_available is set to true then we only want to return
  #     # available products
  #     if args[:only_available] == true
  #       Product.where('inventory_count > 0')
  #     else
  #       Product.all
  #     end
  #   }
  # end

  # Cart Query

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