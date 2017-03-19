require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get marketplace" do
    get products_marketplace_url
    assert_response :success
  end

  test "should get show" do
    get products_show_url
    assert_response :success
  end

end
