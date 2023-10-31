FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { "2023-10-31 16:34:11" }
    updated_at { "2023-10-31 16:34:11" }
  end
end
