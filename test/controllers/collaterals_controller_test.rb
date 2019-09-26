require 'test_helper'

class CollateralsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collaterals_index_url
    assert_response :success
  end

end
