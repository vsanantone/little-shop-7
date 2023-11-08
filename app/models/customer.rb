class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_five_customers
    top_five = Customer.joins(invoices: :transactions).select("customers.first_name, customers.last_name, COUNT(transactions.id) AS successful_transactions_count").where("transactions.result=1").group("customers.id").order("successful_transactions_count DESC").limit(5)
  end
end