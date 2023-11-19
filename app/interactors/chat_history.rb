class ChatHistory
    include Interactor

    def call
        chatting_with = context.params[:chatting_with]
        current_user = context.current_user

        if current_user && chatting_with
            messages_sent_by_current_user = DirectMessage.where(sender_id: current_user, receiver_id: chatting_with)
            messages_sent_by_chatting_user = DirectMessage.where(sender_id: chatting_with, receiver_id: current_user)

            context.messages = messages_sent_by_current_user.or(messages_sent_by_chatting_user)
        end
    end
end