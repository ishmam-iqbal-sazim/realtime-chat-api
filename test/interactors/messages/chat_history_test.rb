require 'test_helper'

class ChatHistoryTest < ActiveSupport::TestCase
    test "successfuly retrieved chat history correct params are passed" do
        params = { chatting_with: 2 }
        current_user = User.find_by(username: "CurrentUser")

        result = Messages::ChatHistory.call(current_user: current_user, params: params)

        assert result.success?
        assert_equal result.messages.length, 2
    end

    test "fails if incorrect params are passed" do 
        result = Messages::ChatHistory.call(params: { chatting_with: "does not match" })

        assert_not result.success?
        assert_not_nil result.error
    end
end