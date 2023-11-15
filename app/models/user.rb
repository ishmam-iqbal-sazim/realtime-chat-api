class User < ApplicationRecord
    validates :username, presence: true, length: {minimum: 3, maximum: 255}
    validates :password, presence: true, length: {minimum: 8, maximum: 255}


    def authenticate(password)
        self.password == password
    end
end
