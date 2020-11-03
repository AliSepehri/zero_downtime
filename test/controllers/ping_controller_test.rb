require 'test_helper'

class PingControllerTest < ActionDispatch::IntegrationTest
  test 'ping' do
    get '/ping'

    assert_response :success
  end
end
