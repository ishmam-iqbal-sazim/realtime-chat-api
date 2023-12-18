require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  def setup
    @user = User.find_by(id: 1)
  end

  test 'user can get all users' do
    policy = UserPolicy.new(@user, User)

    assert policy.get_all_users?
  end

  test 'user cannot get all users' do
    policy = UserPolicy.new(nil, User)

    refute policy.get_all_users?
  end
end
