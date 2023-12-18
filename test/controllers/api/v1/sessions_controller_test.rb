require 'test_helper'

class Api::V1::SessionsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user
    
    setup do
        @fake_user = User.find_by(id: 1)
        @fake_token = "a1b2c3"
    end

    test "#login_user responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:user_data).returns(@fake_user)
        interactor_result.expects(:access_token).returns(@fake_token)

        Users::LoginUser.expects(:call).returns(interactor_result)

        post :login_user, params: { session: { username: "username", password: "password"} }

        assert_response :ok
    end

    test "#login_user does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:error).returns("Handle error msg")
        interactor_result.expects(:status).returns(:bad_request)

        Users::LoginUser.expects(:call).returns(interactor_result)

        post :login_user, params: { session: { username: "username", password: "password"} }

        assert_response :bad_request
    end

    test "#revoke_token responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)

        Users::RevokeToken.expects(:call).returns(interactor_result)

        post :revoke_token, params: { token: @fake_token }

        assert_response :ok
    end

    test "#revoke_token does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)

        Users::RevokeToken.expects(:call).returns(interactor_result)

        post :revoke_token, params: { token: @fake_token }

        assert_response :not_found
    end
end