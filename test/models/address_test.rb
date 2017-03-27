require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "address_to_json method" do
    a = addresses(:one)
    expected = {
      street:        'Avenida Faria Lima',
      street_number: '2927',
      complement:    '8',
      district:      'Itaim',
      city:          'São Paulo',
      state:         'SP',
      country:       'BRA',
      zip_code:      '01234000'
    }
    assert_equal expected, a.address_to_json
  end
end
