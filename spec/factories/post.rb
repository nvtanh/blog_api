FactoryBot.define do
  factory :post do
    title { FFaker::HipsterIpsum.phrase }
    description { FFaker::HipsterIpsum.phrase }
    content { FFaker::HipsterIpsum.paragraph }
    user
  end
end
