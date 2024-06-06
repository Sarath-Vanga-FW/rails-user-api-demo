class Account < ApplicationRecord
    has_many :users, dependent: :destroy 

    validates :name, presence: true
    validates :email, presence: true
end