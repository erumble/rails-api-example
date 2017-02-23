FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { Faker::Crypto.md5 }
  end
end
