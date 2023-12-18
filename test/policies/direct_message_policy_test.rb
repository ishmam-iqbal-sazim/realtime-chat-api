require 'test_helper'

class DirectMessagePolicyTest < ActiveSupport::TestCase
  def setup
    @user = User.find_by(id: 1)
    @other_user = User.find_by(id: 2)
  end

  test 'user can access chat history' do
    direct_message = DirectMessage.new(sender_id: @user.id, receiver_id: @other_user.id)
    policy = DirectMessagePolicy.new(@user, direct_message)

    assert policy.chat_history?
  end

  test 'user cannot access chat history' do
    direct_message = DirectMessage.new(sender_id: @user.id, receiver_id: @other_user.id)
    policy = DirectMessagePolicy.new(nil, direct_message)

    refute policy.chat_history?
  end

  test 'user can send a new message' do
    direct_message = DirectMessage.new(sender_id: @user.id, receiver_id: @other_user.id)
    policy = DirectMessagePolicy.new(@user, direct_message)

    assert policy.new_message?
  end

  test 'user cannot send a new message' do
    direct_message = DirectMessage.new(sender_id: @user.id, receiver_id: @other_user.id)
    policy = DirectMessagePolicy.new(nil, direct_message)

    refute policy.new_message?
  end
end
