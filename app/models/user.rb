class User < ApplicationRecord
    validates :username, presence: true, length: {maximum: 255}
    validates :password, presence: true, length: {maximum: 255}
end
