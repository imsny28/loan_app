require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get attachments_index_url
    assert_response :success
  end

  test "should get edit" do
    get attachments_edit_url
    assert_response :success
  end

  test "should get show" do
    get attachments_show_url
    assert_response :success
  end

  test "should get new" do
    get attachments_new_url
    assert_response :success
  end

  test "should get _form" do
    get attachments__form_url
    assert_response :success
  end

end
