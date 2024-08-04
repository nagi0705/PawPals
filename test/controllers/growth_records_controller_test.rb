require "test_helper"

class GrowthRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get growth_records_new_url
    assert_response :success
  end

  test "should get create" do
    get growth_records_create_url
    assert_response :success
  end

  test "should get index" do
    get growth_records_index_url
    assert_response :success
  end

  test "should get show" do
    get growth_records_show_url
    assert_response :success
  end
end
