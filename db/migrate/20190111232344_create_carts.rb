class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.float :order_total
      t.string :order_status

      t.timestamps
    end
  end
end
