class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    self.product.value * self.quantity
  end
end
