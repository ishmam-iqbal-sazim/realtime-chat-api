require 'test_helper'

class NewMessageTest < ActiveSupport::TestCase
    test "new message succesfully created when correct params are passed" do
        message_params = {content: "Hey, this is a test message", sender_id: 1, receiver_id: 2}

        result = Messages::NewMessage.call(message_params: message_params)

        assert result.success?
        assert_not_nil result.message
    end

    test "failed to create new message when incorrect params passed" do
        result = Messages::NewMessage.call

        assert_not result.success?
        assert_not_nil result.error
    end
end