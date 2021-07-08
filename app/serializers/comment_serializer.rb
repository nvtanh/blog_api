class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :content, :user_email
end
