class Api::V1::DirectMessagesController < ApplicationController
    def index
        sender_id = params[:sender_id]
        receiver_id = params[:receiver_id]

        if sender_id && receiver_id
            messages_sent_by_sender = DirectMessage.where(sender_id: sender_id, receiver_id: receiver_id)
            messages_sent_by_receiver = DirectMessage.where(sender_id: receiver_id, receiver_id: sender_id)

            @messages = messages_sent_by_sender.or(messages_sent_by_receiver)
        end

        render json: @messages
    end

    def new
        message = DirectMessage.new(message_params)
        sender_id = params[:sender_id]
        receiver_id = params[:receiver_id]

        if message.save
            DirectMessageJob.perform_now(message, sender_id, receiver_id)
            
            render json: message
        end
    end

    private

    def message_params
        params.permit(:content, :sender_id, :receiver_id)
    end
end