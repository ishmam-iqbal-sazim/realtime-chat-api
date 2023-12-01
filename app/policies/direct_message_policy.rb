class DirectMessagePolicy < ApplicationPolicy
    def chat_history?
        user.present?
    end

    def new_message?
        user.present?
    end
end