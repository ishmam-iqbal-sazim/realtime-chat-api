class User < ApplicationRecord
    validates :username, presence: true, length: {minimum: 5, maximum: 255}
    validates :password, presence: true, length: {minimum: 8, maximum: 255}
end
