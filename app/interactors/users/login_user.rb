class Users::LoginUser
    include Interactor

    def call
        username = context.session_params[:username]
        password = context.session_params[:password]
        if existing_user = User.find_by_username(username)
            if existing_user.authenticate(password)
                set_context_data(existing_user)
            else
                context.fail!(error: "Invalid credentials", status: :unauthorized)
            end
        else
            context.fail!(error: "User does not exist", status: :not_found)
        end
    end

    private

    def set_context_data(user)
        context.user_data = user
        context.access_token = Users::GenerateAccessToken.call(user: user).access_token 
    end
end
