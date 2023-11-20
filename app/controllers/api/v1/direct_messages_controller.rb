class Api::V1::DirectMessagesController < ApplicationController
    def chat_history
        result = ChatHistoryInteractor.call(current_user: current_user, params: params)

        if result.success?
            render json: result.messages
        end
    end

    def new_message
        result = NewMessageInteractor.call(current_user: current_user, message_params: message_params)

        if result.success?
            render json: result.message
        end
    end

    private

    def message_params
        params.require(:direct_message).permit(:content, :sender_id, :receiver_id)
    end
end
