class PostSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :user_email

  attribute :comment_count do |object|
    object.comments.size
  end
end
