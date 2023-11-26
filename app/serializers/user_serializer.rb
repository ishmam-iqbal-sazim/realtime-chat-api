class UserSerializer < Panko::Serializer
    attributes :id, :username, :token
end