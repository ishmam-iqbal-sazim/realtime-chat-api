class Api::V1::SessionsController < ApplicationController
  def new
    username = session_params[:username]
    password = session_params[:password]

    if existing_user = User.find_by_username(username)
      if authenticate(existing_user, password)
        render json: { id: existing_user.id, username: existing_user.username }
      else
        render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    else
      render json: { error: "User does not exist" }, status: :not_found
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

  def authenticate(user, password)
    user.password == password
  end
end
