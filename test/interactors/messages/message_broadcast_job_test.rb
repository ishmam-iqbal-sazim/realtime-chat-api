require 'test_helper'

class MessageBroadcastJobTest < ActiveSupport::TestCase
    test "succesfully broadcast message" do
        current_user = User.find_by(id: 1)
        message_params = { content: "Hey, this is another test message", sender_id: 1, receiver_id: 2 }

        DirectMessageJob.expects(:perform_now).with({ content: message_params[:content], sender_id: 1, receiver_id: 2 }, 1, 2)

        result = Messages::MessageBroadcastJob.call(current_user: current_user, message_params: message_params, message: message_params)

        assert result.success?
    end
end