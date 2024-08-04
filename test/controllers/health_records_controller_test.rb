require "test_helper"

class HealthRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get health_records_index_url
    assert_response :success
  end

  test "should get show" do
    get health_records_show_url
    assert_response :success
  end

  test "should get new" do
    get health_records_new_url
    assert_response :success
  end

  test "should get edit" do
    get health_records_edit_url
    assert_response :success
  end
end
