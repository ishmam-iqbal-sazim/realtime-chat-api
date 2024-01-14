class Users::BroadcastUserAppearance
    include Interactor

    def call
        user = context.user_data

        user_obj = { id: user.id, username: user.username }

        notify_user_apperance_to_users(user_obj)
  end

  private

  def notify_user_apperance_to_users(user_obj)
    connections = Api::V1::ServerEventsController.class_variable_get(:@@connections)

    connections.each do |user_id, connection|
      connection.write({user: user_obj}, event: "message", retry: 5000) if connection
    end
  end
end