class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
