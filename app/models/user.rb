class User < ApplicationRecord
  devise :database_authenticatable, :validatable, password_length: 8..128

  validates :email, presence: true, uniqueness: true
end
