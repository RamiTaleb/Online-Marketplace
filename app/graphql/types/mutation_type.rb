Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  description 'This file contains all of the mutations that allow for the data
  (products & carts) to be created/updated'

  # Product Mutations

  # This mutation allows you to add a product given the expected
  # arguments (title, price, inventory_count)
  field :create_product, function: Resolvers::CreateProduct.new
  # This mutation allows you to restock a product so that
  # it can be available for purchase
  field :restock_product, function: Resolvers::RestockProduct.new

  # Cart Mutations

  # This mutation allows you to create an empty cart
  field :create_cart, function: Resolvers::CreateCart.new
  # This mutation allows you to add a product to your cart given a product ID
  # and a cart ID
  field :add_to_cart, function: Resolvers::AddToCart.new

  # This mutation will allow you to remove an item from a cart given an
  # item ID and a cart ID
  field :remove_item_from_cart, function: Resolvers::RemoveItemFromCart.new

  # This mutation allows you to checkout a cart. Purchasing all the items
  # within the cart. Must provide a cart ID
  field :checkout_cart, function: Resolvers::CheckoutCart.new
end
