Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  description 'This file contains all of the queries that allow for you to
  view the data in the database'

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