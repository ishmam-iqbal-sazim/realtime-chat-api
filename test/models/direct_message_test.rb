require "test_helper"

class DirectMessageTest < ActiveSupport::TestCase
  should validate_presence_of(:content)

  test 'message is created with validations' do
    valid_message = DirectMessage.new(
      content: 'Valid message',
    )
    assert valid_message.valid?
    assert_empty valid_message.errors

    invalid_message = DirectMessage.new(
      content: '',
    )
    assert_not invalid_message.valid?
    assert_not_empty invalid_message.errors[:content]
  end
end
