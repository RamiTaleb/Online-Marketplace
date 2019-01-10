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

  field :purchase_product, Types::ProductType do
    argument :id, !types.ID
    description 'Purchase a product (decreases the inventory count of product by 1)'

    resolve ->(obj, args, ctx) {
      prod = Product.find_by(id: args[:id])
      count = prod.inventory_count
      if count > 0
        count -= 1
        prod.inventory_count = count
        prod.save
      end
      Product.find_by(id: args[:id])
    }
  end

end
