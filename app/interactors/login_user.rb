class LoginUser
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
        context.user_data = UserSerializer.new.serialize_to_json(user)
    end
end