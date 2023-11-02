class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum:status, ["pending", "packaged", "shipped"]

  def self.incomplete_invoices
    InvoiceItem.select("invoice_id").where("status != 2").group("invoice_id").order("invoice_id")
  end
end