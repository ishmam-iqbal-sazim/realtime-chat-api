class Api::V1::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create_new_user

  def index
    authorize User

    @users = User.where.not(id: current_user.id).select('id, username, created_at, updated_at')

    render json: @users
  end

  def create_new_user
    result = CreateNewUser.call(user_params: user_params)

    if result.success?
      render json: result.user_data
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end