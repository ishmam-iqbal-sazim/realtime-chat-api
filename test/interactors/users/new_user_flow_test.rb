require "test_helper"

class Users::NewUserFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Users::NewUserFlow.organized, [
      Users::CreateNewUser,
      Users::BroadcastUserAppearance
    ]
  end
end