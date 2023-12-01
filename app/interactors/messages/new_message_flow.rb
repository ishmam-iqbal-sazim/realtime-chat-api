class Messages::NewMessageFlow
    include Interactor::Organizer

    organize Messages::NewMessage, 
             Messages::MessageBroadcastJob
end