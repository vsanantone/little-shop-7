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

end