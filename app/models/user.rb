class User < ApplicationRecord
  belongs_to :account

  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true
end
