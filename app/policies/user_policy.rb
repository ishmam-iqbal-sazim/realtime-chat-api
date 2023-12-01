class UserPolicy < ApplicationPolicy
    def get_all_users?
      user.present?
    end
end
