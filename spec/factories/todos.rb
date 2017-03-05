FactoryGirl.define do
  factory :todo do
    title { Faker::Job.title }
    user
  end
end
