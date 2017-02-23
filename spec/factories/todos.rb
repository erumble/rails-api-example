FactoryGirl.define do
  factory :todo do
    title { Faker::Job.title }
  end
end
