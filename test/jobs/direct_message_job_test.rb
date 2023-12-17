require "test_helper"

class DirectMessageJobTest < ActiveJob::TestCase
  test 'broadcasts messages to correct channels' do
    message = 'Test message'
    sender_id = 1
    receiver_id = 2

    ActionCable.server.expects(:broadcast).with("private_#{receiver_id}_#{sender_id}", message)
    ActionCable.server.expects(:broadcast).with("private_#{sender_id}_#{receiver_id}", message)

    DirectMessageJob.perform_now(message, sender_id, receiver_id)
  end
end
