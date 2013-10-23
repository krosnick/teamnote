require 'test_helper'

class AuthorizationsControllerTest < ActionController::TestCase
  test "should get share" do
    get :share
    assert_response :success
  end

  test "should get give_access" do
    get :give_access
    assert_response :success
  end

end
