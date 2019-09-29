require 'test_helper'

class CollateralTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collateral_types_index_url
    assert_response :success
  end

  test "should get edit" do
    get collateral_types_edit_url
    assert_response :success
  end

  test "should get new" do
    get collateral_types_new_url
    assert_response :success
  end

end
