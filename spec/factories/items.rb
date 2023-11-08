FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Commerce.price(range: 0..10.0, as_string: true) }
    status { 1 }
    created_at { "2023-10-31 16:40:54" }
    updated_at { "2023-10-31 16:40:54" }
  end
end
