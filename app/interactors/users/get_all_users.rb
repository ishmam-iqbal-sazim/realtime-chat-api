class Users::GetAllUsers
    include Interactor

    def call
        if context.id
            if all_users = User.where.not(id: context.id).select('id, username, created_at, updated_at')
                context.all_users = all_users 
            else
                context.fail!(error: "Fetch all users failed", status: :not_found)
            end
        else
            context.fail!(error: "Not authorized", status: :unauthorized)
        end
    end
end