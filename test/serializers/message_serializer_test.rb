require 'test_helper'

class MessageSerializerTest < ActiveSupport::TestCase
  test 'should render correct attributes' do
    message_data = {
      content: 'Hello, this is a message',
      id: 1,
      receiver_id: 2,
      sender_id: 1
    }

    serialized_object = MessageSerializer.new.serialize(OpenStruct.new(message_data))
    parsed_object = JSON.parse(serialized_object.to_json)

    assert_equal message_data[:content], parsed_object['content']
    assert_equal message_data[:id], parsed_object['id']
    assert_equal message_data[:receiver_id], parsed_object['receiver_id']
    assert_equal message_data[:sender_id], parsed_object['sender_id']
  end
end
