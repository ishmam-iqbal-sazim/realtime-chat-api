class LoginUserInteractor
    include Interactor
    include Panko

    def call
        username = context.session_params[:username]
        password = context.session_params[:password]
        if existing_user = User.find_by_username(username)
            if authenticate(existing_user, password)
                set_user_context_data(existing_user)
            else
                context.fail!(error: "Invalid credentials", status: :unauthorized)
            end
        else
            context.fail!(error: "User does not exist", status: :not_found)
        end
    end

    private

    def authenticate(user, password)
        user.password == password
    end

    def set_user_context_data(user)
        user_data = UserSerializer.new.serialize(user)

        access_token = GenerateAccessTokenInteractor.call(user: user).access_token

        user_data["token"] = access_token

        context.user_data = user_data.to_json
    end
end
