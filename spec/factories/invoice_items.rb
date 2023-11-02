FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { 1 }
    unit_price { item.unit_price }
    status { [0, 1, 2].sample }
    created_at { invoice.created_at }
    updated_at { invoice.updated_at }
  end
end
