class Messages::MessageBroadcastJob
    include Interactor

    def call
        message = context.message
        sender_id = context.current_user.id
        receiver_id = context.message_params[:receiver_id]

        DirectMessageJob.perform_now(message, sender_id, receiver_id)
    end
end