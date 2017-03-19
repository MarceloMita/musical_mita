class Product < ApplicationRecord
  is_sluggable :title
  
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
end
