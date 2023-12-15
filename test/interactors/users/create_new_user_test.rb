require 'test_helper'

class Users::CreateNewUserTest < ActiveSupport::TestCase
  test "creates new user when correct params are passed" do
    user_params = {username: "newTestUser", password: "password"}

    result = Users::CreateNewUser.call(user_params: user_params)

    assert result.success?
    assert_not_nil result.user_data
    assert_not_nil result.access_token
  end

  test "returns error if user already exists" do
    current_user = User.find_by(id: 1)
    user_params = { username: current_user.username, password: current_user.password }

    result = Users::CreateNewUser.call(user_params: user_params)

    assert_not result.success?
    assert_nil result.user_data
    assert_nil result.access_token
    assert_not_nil result.error
  end
end
