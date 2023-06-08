FactoryBot.define do
  factory :astronaut do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    age { Faker::Number.between(from: 18, to: 50) }
  end
end