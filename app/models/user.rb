class User < ApplicationRecord
  devise :database_authenticatable, :validatable, password_length: 8..128

  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
