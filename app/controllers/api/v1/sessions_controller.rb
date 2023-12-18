class Api::V1::SessionsController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: [:login_user]

  def login_user 
    result = Users::LoginUser.call(session_params: session_params)

    if result.success?
      serialized_user = UserSerializer.new.serialize(result.user_data)
      serialized_user["token"] = result.access_token

      render json: serialized_user
    else
      render json: { error: result.error }, status: result.status
    end
  end

  def revoke_token
    result = Users::RevokeToken.call(token: params[:token])

    if result.success?
      render json: { message: 'Token successfully revoked' }
    else
      render json: { error: "Token not found" }, status: :not_found
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
