class Merchant < ApplicationRecord
  include CurrencyConverter
  has_many :items 

  validates :name, presence: true
  
  def self.top_five_merchants
    Merchant.joins(items: { invoices: [:invoice_items, :transactions] })
            .select("merchants.id, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
            .where("transactions.result=1")
            .group("merchants.id")
            .order("total_revenue DESC")
            .limit(5)
  end

  def top_5_customers
    top_5 = Customer.joins(invoices: :items)
      .where("invoices.status = 1 AND items.merchant_id = #{id}")
      .select("count(invoices.id), customers.*")
      .group("customers.id")
      .order("count DESC")
      .limit(5)
  end

  def shippable_items
    Invoice.joins(invoice_items: :item)
      .select("invoices.id AS invoice_id, invoices.created_at AS order_date, items.name AS name")
      .where("invoices.status = 0 AND items.merchant_id = #{id}")
      .group("invoices.id, name")
      .order("order_date")
  end

  def self.merchant_status(status)
    Merchant.where("merchants.enabled = #{status}")
  end

  def invoices
    Invoice.joins(:items)
      .select("invoices.*")
      .where("items.merchant_id = #{id}")
      .group("invoices.id")
      .order("invoices.id")
  end

  def top_5_items
    items
      .joins(:invoice_items)
      .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS item_revenue")
      .where("invoice_items.status = ?", 1)
      .group("items.id")
      .order("item_revenue DESC")
      .limit(5)
  end

  def self.top_five_merchants
    Merchant.joins(items: { invoices: [:invoice_items, :transactions] })
            .select("merchants.id, merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
            .where("transactions.result=1")
            .group("merchants.id")
            .order("total_revenue DESC")
            .limit(5)
  end

  def self.top_merchant_best_day
    top_merchant = Merchant.top_five_merchants.first
    Invoice.joins(:transactions, :items)
            .select("invoices.created_at as order_date, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
            .where("transactions.result = 1 AND items.merchant_id = #{top_merchant.id}")
            .group("order_date")
            .order("total_revenue DESC, order_date DESC")
            .limit(1).first
  end
end
