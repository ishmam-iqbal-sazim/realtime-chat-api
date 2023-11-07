class DirectMessage < ApplicationRecord
    validates :content, presence: true, length: {maximum: 1000}
end
