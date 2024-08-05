require "test_helper"

class PetDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pet_details_new_url
    assert_response :success
  end

  test "should get create" do
    get pet_details_create_url
    assert_response :success
  end

  test "should get edit" do
    get pet_details_edit_url
    assert_response :success
  end

  test "should get update" do
    get pet_details_update_url
    assert_response :success
  end

  test "should get show" do
    get pet_details_show_url
    assert_response :success
  end
end
