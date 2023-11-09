FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    # disabled { false }
    created_at { "2023-10-31 16:41:38" } # talk with group. Not a reason to have every single merchant have the same created/updated date.
    updated_at { "2023-10-31 16:41:38" } # talk with group. Not a reason to have every single merchant have the same created/updated date.
  end
end
