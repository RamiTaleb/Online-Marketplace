Types::CartType = GraphQL::ObjectType.define do
  name 'Cart'

  field :id, !types.ID
  field :order_total, !types.Float
  field :order_status, !types.String
  field :items, !types[Types::ItemType]
end