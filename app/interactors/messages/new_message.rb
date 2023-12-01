class Messages::NewMessage
    include Interactor
    include Panko

    def call
        message = DirectMessage.new(context.message_params)

        if message.save
            context.message = message
        else
            context.fail!(error: "New message save failed")
        end
    end
end
