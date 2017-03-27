require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  test "phone_to_json method" do
    phone = phones(:one)
    expected = {
      country_code: '55',
      area_code: '11',
      number: '99999999'
    }
    assert_equal expected, phone.phone_to_json
  end
end
