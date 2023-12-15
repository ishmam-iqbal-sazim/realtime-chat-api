require 'test_helper'

class BroadcastUserAppearanceTest < ActiveSupport::TestCase
    test "successfully broadcasts new user" do
        user = User.find_by(id: 1)

        ActionCable.server.expects(:broadcast).with("user_appearance", { id: user.id, username: user.username })

        result = Users::BroadcastUserAppearance.call(user_data: user)

        assert result.success?
    end
end