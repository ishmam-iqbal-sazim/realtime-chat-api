require 'test_helper'

class Users::GenerateAccessTokenTest < ActiveSupport::TestCase
  test "token successfully revokes if valid" do
    current_user = User.find_by(id: 1)

    result = Users::GenerateAccessToken.call(user: current_user)

    assert result.success?
    assert_not_nil result.access_token
  end
end
