class Merchant < ApplicationRecord
  has_many :items 

  validates :name, presence: true
  
  def top_5_customers
    top_5 = Customer.joins(invoices: :items)
      .where("invoices.status = 1 AND items.merchant_id = #{self.id}")
      .select("count(invoices.id), customers.*")
      .group("customers.id")
      .order("count DESC")
      .limit(5)
  end

  def shippable_items
    Invoice.joins(invoice_items: :item)
    .select("invoices.id AS invoice_id, invoices.created_at AS order_date, items.name AS name")
    .where("invoices.status = 0 AND items.merchant_id = #{self.id}")
    .group("invoices.id, name")
    .order("order_date")
  end

  def invoices
    Invoice.joins(:items)
    .select("invoices.*")
    .where("items.merchant_id = #{self.id}")
    .group("invoices.id")
    .order("invoices.id")
  end
end