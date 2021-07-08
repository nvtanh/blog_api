class DetailPostSerializer < PostSerializer
  attributes :content

  attribute :comments do |object|
    CommentSerializer.new(object.comments.includes(:user)).serializable_hash
  end
end
