class NewMessage
    include Interactor

    def call
        sender_id = context.current_user.id
        receiver_id = context.message_params[:receiver_id]

        message = DirectMessage.new(context.message_params)

        if message.save
            DirectMessageJob.perform_now(message, sender_id, receiver_id)
            
            context.message = message
        end
    end
end