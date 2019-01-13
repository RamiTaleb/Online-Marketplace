class Resolvers::CreateCart < GraphQL::Function
  description 'Create an empty cart to begin adding products to'

  # return type from the mutation
  type Types::CartType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context
  def call(_obj, args, _ctx)
    Cart.create!(
      order_total: 0,
      order_status: 'In Progress'
    )
  end
end
