FactoryBot.define do
  factory :post do
    title { FFaker::HipsterIpsum.phrase }
    description { FFaker::HipsterIpsum.paragraph }
    content { FFaker::HipsterIpsum.paragraphs }
    user
  end
end
