class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates :status, presence: true

  enum:status, ["in progress", "completed", "cancelled"]

  def self.incomplete_invoices
    Invoice.select("invoices.id, invoices.created_at").where("status=0").group("invoices.id").order("invoices.created_at DESC")
  end

  def total_revenue
    total_revenue_cents = 0
    successful = self.transactions.select do |transaction|
      if transaction.result == "success"
        true
      end
    end

    if successful != nil
      self.invoice_items.each do |invoice_item|
        total_revenue_cents += (invoice_item.quantity * invoice_item.unit_price).to_f
      end
    end
    total_revenue = (total_revenue_cents / 100).round(2)
  end
end