require 'test_helper'

class UserSerializerTest < ActiveSupport::TestCase
  test 'should render correct attributes' do
    user_data = {
      id: 1,
      username: 'test_user',
      token: 'sample_token'
    }

    serialized_object = UserSerializer.new.serialize(OpenStruct.new(user_data))
    parsed_object = JSON.parse(serialized_object.to_json)

    assert_equal user_data[:id], parsed_object['id']
    assert_equal user_data[:username], parsed_object['username']
    assert_equal user_data[:token], parsed_object['token']
  end
end
