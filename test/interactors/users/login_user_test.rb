require 'test_helper'

class Users::LoginUserTest < ActiveSupport::TestCase
  test "logs in user when correct params are passed" do
    session_params = { username: "CurrentUser", password: "password" }

    result = Users::LoginUser.call(session_params: session_params)

    assert result.success?
    assert_not_nil result.user_data
    assert_not_nil result.access_token
  end

  test "returns error if user does not exist" do
    session_params = { username: "NonExistentUser", password: "password" }

    result = Users::LoginUser.call(session_params: session_params)

    assert_not result.success?
    assert_nil result.user_data
    assert_not_nil result.error
  end

  test "returns error if passwords don't match" do
    session_params = { username: "CurrentUser", password: "passwordDon'tMatch" }

    result = Users::LoginUser.call(session_params: session_params)

    assert_not result.success?
    assert_nil result.user_data
    assert_not_nil result.error
  end
end
