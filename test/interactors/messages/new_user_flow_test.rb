require "test_helper"

class Messages::NewMessageFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Messages::NewMessageFlow.organized, [
      Messages::NewMessage,
      Messages::MessageBroadcastJob
    ]
  end
end