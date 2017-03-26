require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get moip" do
    get webhooks_moip_url
    assert_response :success
  end

end
