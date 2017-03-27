require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  test "subtotal method" do
    cart_item1 = cart_items(:one)
    assert_equal 1400.0, cart_item1.subtotal
    cart_item2 = cart_items(:two)
    assert_equal 800.0, cart_item2.subtotal
  end
end
