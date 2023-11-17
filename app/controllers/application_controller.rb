class ApplicationController < ActionController::API
  include Pundit

  before_action :doorkeeper_authorize!

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end