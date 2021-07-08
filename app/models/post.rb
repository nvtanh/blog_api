class Post < ApplicationRecord
  include Filterable

  belongs_to :user
  has_many :comments

  delegate :email, to: :user, prefix: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  scope :newest, -> { order :created_at }
  scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
  scope :filter_by_title, -> (title) do
    where "#{Post.table_name}.title LIKE ?", "%#{title}%"
  end
end
