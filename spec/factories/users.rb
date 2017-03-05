FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    sub { Faker::Crypto.md5 }
  end
end
