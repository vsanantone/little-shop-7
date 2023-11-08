class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  enum :status, ["disabled", "enabled"]

  def best_day
    Item
      .joins(:invoices)
      .where("items.id = ?", id)
      .select("SUM(invoice_items.quantity) as items_sold, invoices.created_at::date as created_at")
      .group("invoices.created_at::date")
      .order("items_sold DESC, created_at DESC")
      .limit(1)
      .first
  end
end
