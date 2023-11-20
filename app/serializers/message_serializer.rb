class MessageSerializer < Panko::Serializer
    attributes :content, :id, :receiver_id, :sender_id
end