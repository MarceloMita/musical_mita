class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def calculate_subtotal_value
    self.cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.subtotal
    end
  end

  def calculate_discount
    calculate_subtotal_value * 0.05
  end

  def calculate_total_value
    calculate_subtotal_value - calculate_discount
  end

  def quantity
    self.cart_items.inject(0) { |sum, cart_item| sum + cart_item.quantity }
  end
end
