class Item < ApplicationRecord
  # Has a foreign key for both these models
  belongs_to :product
  belongs_to :cart
end
