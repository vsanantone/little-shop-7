class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates :status, presence: true

  enum :status, ["in progress", "completed", "cancelled"]

  def self.incomplete_invoices
    Invoice.select("invoices.id, invoices.created_at").where("status=0").group("invoices.id").order("invoices.created_at DESC")
  end

  def total_revenue
    successful_transaction_ids = transactions.where(result: "success").pluck(:id)

    total_revenue_cents = invoice_items
      .joins(invoice: :transactions)
      .where(transactions: {id: successful_transaction_ids})
      .sum("quantity * unit_price")

    total_revenue = (total_revenue_cents / 100.0)
  end

  def merchant_revenue(merchant_id)
    items.where("merchant_id = #{merchant_id}").sum(:unit_price)
  end

  def merchant_items(merchant_id)
    items.where("merchant_id = #{merchant_id}")
  end

  def count_items(item_id)
    invoice_items.where("item_id = #{item_id}").count
  end
end
