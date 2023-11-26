class RevokeTokenInteractor
  include Interactor

  def call
    token = context.token

    application = Doorkeeper::Application.find_by(uid: 'B_hwvv-JxtjD3QEph4sN9BRwuKYvv34Oq45naHgFEF4')

      token_to_revoke = Doorkeeper::AccessToken.find_by(token: token, application_id: application.id)
      if token_to_revoke.present?
        token_to_revoke.update(revoked_at: Time.now)
      else
        context.fail!(error: 'Invalid token')
      end
  end
end