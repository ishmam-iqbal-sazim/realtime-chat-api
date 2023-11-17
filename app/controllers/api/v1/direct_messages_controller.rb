class Api::V1::DirectMessagesController < ApplicationController
    def index
        chatting_with = params[:chatting_with]

        if current_user && chatting_with
            messages_sent_by_current_user = DirectMessage.where(sender_id: current_user, receiver_id: chatting_with)
            messages_sent_by_chatting_user = DirectMessage.where(sender_id: chatting_with, receiver_id: current_user)

            @messages = messages_sent_by_current_user.or(messages_sent_by_chatting_user)
        end

        render json: @messages
    end

    def new
        sender_id = current_user.id
        receiver_id = params[:receiver_id]

        message = DirectMessage.new(message_params)

        if message.save
            DirectMessageJob.perform_now(message, sender_id, receiver_id)
            
            render json: message
        end
    end

    private

    def message_params
        params.require(:direct_message).permit(:content, :sender_id, :receiver_id)
    end
end