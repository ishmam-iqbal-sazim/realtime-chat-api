class Api::V1::DirectMessagesController < ApplicationController
    include Panko
    before_action :authorize_direct_message

    def chat_history
        result = Messages::ChatHistory.call(current_user: current_user, params: params)

        if result.success?
            serialized_messages = ArraySerializer.new(result.messages, each_serializer: MessageSerializer).to_json
            render json: serialized_messages
        else
            render json: { error: result.error }, status: :not_found
        end
    end

    def new_message
        result = Messages::NewMessageFlow.call(current_user: current_user, message_params: message_params)

        if result.success?
            serialized_message = MessageSerializer.new.serialize_to_json(result.message)

            render json: serialized_message
        else
            render json: { error: result.error }, status: :bad_request
        end
    end

    private

    def authorize_direct_message
        authorize DirectMessage
    end

    def message_params
        params.require(:direct_message).permit(:content, :sender_id, :receiver_id)
    end
end
