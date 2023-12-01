class Users::GetAllUsers
    include Interactor

    def call
        context.fail!(error: "Invalid credentials", status: :unauthorized) unless context.all_users = User.where.not(id: context.current_user_id).select('id, username, created_at, updated_at')
    end
end