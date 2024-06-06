require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  test "check fetching all users" do
    get "/users"
    assert_response :success
  end
end
