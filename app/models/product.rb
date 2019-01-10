class Product < ApplicationRecord
  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false,
                          message: 'Product name has already been listed!' }

  validates :price,
            presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :inventory_count,
            presence: true, numericality: { only_integer: true,
                                            greater_than: 0 }
end
