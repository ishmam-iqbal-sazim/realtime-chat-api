class CreateNewUserInteractor
  include Interactor
  include Panko

  def call
    username = context.user_params[:username]
    password = context.user_params[:password]

    if existing_user = User.find_by_username(username)
      context.fail!(error: "Username already exists")
    else
      user = User.new(context.user_params)
      if user.save
        broadcast_user_appearance(user)
        set_user_context_data(user)
      end
    end
  end

  private

  def broadcast_user_appearance(user)
    ActionCable.server.broadcast "user_appearance", { id: user.id, username: user.username }
  end

  def set_user_context_data(user)
    user_data = UserSerializer.new.serialize(user)

    user_data["token"] = GenerateAccessTokenInteractor.call(user: user).access_token

    context.user_data = user_data.to_json
  end
end
