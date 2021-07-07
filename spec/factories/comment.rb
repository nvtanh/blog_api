FactoryBot.define do
  factory :comment do
    content { FFaker::HipsterIpsum.paragraph }
    post
    user
  end
end
