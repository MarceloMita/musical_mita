class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    cart_item.product.value * cart_item.quantity
  end
end
