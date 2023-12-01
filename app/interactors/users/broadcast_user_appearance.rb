class Users::BroadcastUserAppearance
    include Interactor

    def call
        user = context.user_data

        ActionCable.server.broadcast "user_appearance", { id: user.id, username: user.username }
    end
end