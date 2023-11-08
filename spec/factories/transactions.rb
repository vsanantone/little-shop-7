FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { 1 }
    created_at { "2023-10-31 16:42:14" }
    updated_at { "2023-10-31 16:42:14" }
  end
end
