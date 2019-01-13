class Product < ApplicationRecord
  # We want to ensure that product names are not duplicated
  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false,
                          message: 'Product name has already been listed!' }

  # We want to ensure that prices are not negative
  validates :price,
            presence: true, numericality: { greater_than_or_equal_to: 0 }

  # We want to ensure that the inventory count is not negative
  validates :inventory_count,
            presence: true, numericality: { only_integer: true,
                                            greater_than_or_equal_to: 0 }

  has_many :items
end