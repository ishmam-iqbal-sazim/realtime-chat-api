require 'test_helper'

class Users::RevokeTokenTest < ActiveSupport::TestCase
  test "token successfully revokes if valid" do
    valid_token = Doorkeeper::AccessToken.create!(
      resource_owner_id: 1,
      application_id: Doorkeeper::Application.find_by(uid: 'B_hwvv-JxtjD3QEph4sN9BRwuKYvv34Oq45naHgFEF4').id,
      scopes: ''
    ).token

    result = Users::RevokeToken.call(token: valid_token)

    assert result.success?
  end

  test "returns error if token is invalid" do
    invalid_token = "invalid"
    result = Users::RevokeToken.call(token: invalid_token)

    assert_not result.success?
    assert_not_nil result.error
  end
end
