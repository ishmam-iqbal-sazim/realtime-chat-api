class Api::V1::SessionsController < ApplicationController
  skip_before_action :doorkeeper_authorize!

  def login_user 
    result = LoginUser.call(session_params: session_params)

    if result.success?
      render json: result.user_data
    else
      render json: { error: result.error }, status: result.status
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
