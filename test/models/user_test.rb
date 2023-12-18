require "test_helper"

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_presence_of(:password)

  test 'user is created with validations' do
    valid_user = User.new(
      username: 'validUsername',
      password: 'validPassword'
    )

    assert valid_user.valid?
    assert_empty valid_user.errors

    invalid_user = User.new(
      username: '',
      password: ''
    )

    assert_not invalid_user.valid?
    assert_not_empty invalid_user.errors[:username]
    assert_not_empty invalid_user.errors[:password]
  end
end
