class MessagesSerializer < Panko::Serializer
    attributes :id, :content, :sender_id, :receiver_id
end