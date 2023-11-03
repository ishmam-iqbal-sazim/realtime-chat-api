class Api::V1::UsersController < ApplicationController
    def index
        @users = User.all

        render json: @users
    end

    def create
        username = user_params[:username]
        password = user_params[:password]
        
        if existing = User.find_by_username(name)
            if authenticate(existing, password)
                render json: existing
            else
                render json: "Invalid credentials"
            end
        else
            user = User.new(user_params)
            render json: user if user.save
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