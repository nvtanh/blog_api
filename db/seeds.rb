### Clear DB
User.destroy_all
Post.destroy_all
Comment.destroy_all

### Create Users
10.times do |i|
  User.create!(email: "email_#{i}@sample.com", password: "12345678", password_confirmation: "12345678")
end

### Create Posts
User.all.each do |user|
  5.times do |_i|
    Post.create(user: user, title: FFaker::Lorem.phrase,
      description: FFaker::Lorem.paragraph, content: FFaker::Lorem.paragraph)
  end
end

### Create comment
user_ids = User.pluck(:id)
Post.all.each do |post|
  2.times do |_i|
    Comment.create(user_id: user_ids.sample, post: post, content: FFaker::Lorem.paragraph)
  end
end
