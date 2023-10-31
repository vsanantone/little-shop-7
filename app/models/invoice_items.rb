class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  vaildates :quantity, presence: true
  vaildates :unit_price, presence: true
  vaildates :status, presence: true

  enum:status, ["pending", "packaged", "shipped"]
end