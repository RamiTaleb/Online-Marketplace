Types::ItemType = GraphQL::ObjectType.define do
  name 'Item'

  field :id, !types.ID
  field :title, !types.String
  field :price, !types.Float
  field :product, !types.ID
  field :cart, !types.ID
end