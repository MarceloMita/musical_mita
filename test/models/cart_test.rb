require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "calculate_subtotal_value method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 2200.0, cart1.calculate_subtotal_value
    assert_equal 1600.0, cart2.calculate_subtotal_value
  end

  test "calculate_discount method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 110.0, cart1.calculate_discount
    assert_equal 0.0, cart2.calculate_discount
  end

  test "calculate_additions method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 0.0, cart1.calculate_additions
    assert_equal 40.0, cart2.calculate_additions
  end

  test "calculate_total_value method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 2090.0, cart1.calculate_total_value
    assert_equal 1600.0, cart2.calculate_total_value
  end

  test "calculate_total_price method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 2090.0, cart1.calculate_total_price
    assert_equal 1640.0, cart2.calculate_total_price
  end

  test "quantity method" do
    cart1 = carts(:one)
    cart2 = carts(:two)
    assert_equal 3, cart1.quantity
    assert_equal 2, cart2.quantity
  end
end
