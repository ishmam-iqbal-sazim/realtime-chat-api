class Users::CreateNewUser
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
        set_context_data(user)
      else
        context.fail!(error: "Failed to create new user")
      end
    end
  end

  private

  def set_context_data(user)
    context.user_data = user
    context.access_token = Users::GenerateAccessToken.call(user: user).access_token 
  end
end
