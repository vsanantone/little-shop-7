class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum:status, ["pending", "packaged", "shipped"]

  def unit_price_show
    unit_price_formatted = (self.unit_price.to_f / 100).round(2)
  end
end