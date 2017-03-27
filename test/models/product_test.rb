require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'Should be able to find using slug' do
    assert_equal products(:two), Product.find_using_slug('violino')
  end
end
