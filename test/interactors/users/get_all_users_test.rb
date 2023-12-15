require 'test_helper'

class Users::GetAllUsersTest < ActiveSupport::TestCase
  test "finds and returns all users except the current user when correct params are passed" do
    current_user = User.find_by(username: "CurrentUser")

    expected_data = [
      User.create!(username: "User3", password: "password"),
      User.create!(username: "User4", password: "password")
    ]

    result = Users::GetAllUsers.call(id: current_user.id)

    assert result.success?
    assert_equal result.all_users.length, 3
    assert_nil result.all_users.find { |user| user.id == current_user.id }
  end

  test "returns error when correct params are not passed" do
    result = Users::GetAllUsers.call

    assert_not result.success?
    assert_not_nil result.error
  end
end
