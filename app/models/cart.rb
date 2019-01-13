class Cart < ApplicationRecord
  # Cart -> Item is a 1 - * association
  has_many :items
end
