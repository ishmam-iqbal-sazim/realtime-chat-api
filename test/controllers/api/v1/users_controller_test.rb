require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "#get_all_users responds with success" do
        users = User.all

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:all_users).returns(users)

        Users::GetAllUsers.expects(:call).returns(interactor_result)

        get :get_all_users, params: { id: 1 }

        assert_response :ok
    end

    test "#get_all_users does respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:error).returns("some error")

        Users::GetAllUsers.expects(:call).returns(interactor_result)

        get :get_all_users, params: { id: 1 }

        assert_response :unprocessable_entity
    end

    test "#create_new_user responds with success" do
        new_user = User.new(username: "New test user", password: "password")
        token = "sample_token"

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:user_data).returns(new_user)
        interactor_result.expects(:access_token).returns(token)

        Users::NewUserFlow.expects(:call).returns(interactor_result)

        post :create_new_user, params: { user: { username: "username", password: "password"} }

        response_body = JSON.parse(response.body)

        assert_response :ok
    end

    test "#create_new_user does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:error).returns("Handle error msg")
        interactor_result.expects(:status).returns(:bad_request)

        Users::NewUserFlow.expects(:call).returns(interactor_result)

        post :create_new_user, params: { user: { username: "username", password: "password"} }

        assert_response :bad_request
    end
end