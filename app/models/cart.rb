class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def calculate_total_value
    self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.product.value * cart_item.quantity
    end
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end
end
