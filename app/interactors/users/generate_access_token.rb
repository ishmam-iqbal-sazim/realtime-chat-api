class Users::GenerateAccessToken
  include Interactor

  def call
    user = context.user

    application = Doorkeeper::Application.find_by(uid: 'B_hwvv-JxtjD3QEph4sN9BRwuKYvv34Oq45naHgFEF4')

    context.fail!(error: "Something went wrong", status: :unprocessable_entity) unless token_request = Doorkeeper::AccessToken.create!(
      resource_owner_id: user.id,
      application_id: application.id,
      scopes: ''
    )

    context.access_token = token_request.token
  end
end

