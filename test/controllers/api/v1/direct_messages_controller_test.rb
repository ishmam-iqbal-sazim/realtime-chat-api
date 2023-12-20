require 'test_helper'

class Api::V1::DirectMessagesControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user
    
    setup do
        @fake_user = User.find_by(id: 1)
    end

    test "#chat_history responds with success" do
        params = { direct_message: { sender_id: 1, receiver_id: 2 } }
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:messages).returns([])

        Messages::ChatHistory.expects(:call).returns(interactor_result)

        get :chat_history, params: { params: params, current_user: @fake_user }

        assert_response :ok
    end

    test "#chat_history does not respond with success" do
        params = { direct_message: { sender_id: 1, receiver_id: 2 } }
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:error).returns("some error")

        Messages::ChatHistory.expects(:call).returns(interactor_result)

        get :chat_history, params: { params: params, current_user: @fake_user }

        assert_response :not_found
    end

    test "#new_message responds with success" do
        test_params = { direct_message: { content: "mock", sender_id: 1, receiver_id: 2 } }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:message).returns({})

        Messages::NewMessageFlow.expects(:call).returns(interactor_result)

        post :new_message, params: { direct_message: test_params, current_user: @fake_user }

        assert_response :ok
    end

    test "#new_message does not respond with success" do
        test_params = { direct_message: { content: "mock", sender_id: 1, receiver_id: 2 } }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:error).returns("some error")

        Messages::NewMessageFlow.expects(:call).returns(interactor_result)

        post :new_message, params: { direct_message: test_params, current_user: @fake_user }

        assert_response :bad_request
    end
end