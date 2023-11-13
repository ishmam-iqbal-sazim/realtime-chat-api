class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all.select('id, username, created_at, updated_at')

        render json: @users
    end

    def create
        username = user_params[:username]
        password = user_params[:password]
        
        if existing_user = User.find_by_username(username)
            if authenticate(existing_user, password)
                render json: { id: existing_user.id, username: existing_user.username }
            else
               render json: { error: "Invalid credentials" }, status: :unauthorized 
            end
        else
            user = User.new(user_params)
            if user.save
                ActionCable.server.broadcast "user_appearance", { id: user.id, username: user.username }
                render json: { id: user.id, username: user.username }
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end

    def authenticate(user, password)
        user.password == password
    end
end