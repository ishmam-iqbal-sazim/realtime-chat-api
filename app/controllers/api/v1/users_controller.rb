class Api::V1::UsersController < ApplicationController
    skip_before_action :doorkeeper_authorize!, only: :create

    def index
        authorize User

        @users = User.where.not(id: current_user.id).select('id, username, created_at, updated_at')

        render json: @users
    end

    def create
        username = user_params[:username]
        password = user_params[:password]
        
        if existing_user = User.find_by_username(username)
            render json: { error: "Username already exists"}, status: :unprocessable_entity
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
end