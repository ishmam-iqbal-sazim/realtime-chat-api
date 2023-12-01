class Api::V1::UsersController < ApplicationController
  include Panko
  skip_before_action :doorkeeper_authorize!, only: [:create_new_user]

  def get_all_users
    authorize User

    result = Users::GetAllUsers.call(id: current_user.id)

    if result.success?
      serialized_users = ArraySerializer.new(result.all_users, each_serializer: UserSerializer).to_json 
      render json: serialized_users
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def create_new_user
    result = Users::NewUserFlow.call(user_params: user_params)

    if result.success?
      serialized_user = UserSerializer.new.serialize(result.user_data)
      serialized_user["token"] = result.access_token

      render json: serialized_user
    else
      render json: { error: result.error }, status: result.status
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
