require 'test_helper'

class AttributeOptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get attribute_options_index_url
    assert_response :success
  end

end
