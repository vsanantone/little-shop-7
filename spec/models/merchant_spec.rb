require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)
    @item_5 = create(:item, merchant_id: @merchant.id)
    @item_6 = create(:item, merchant_id: @merchant.id)

    @customer_1 = create(:customer)
    @c1_invoice_1 = create(:invoice, status: 1, customer_id: @customer_1.id)
    @c1_invoice_2 = create(:invoice, status: 1, customer_id: @customer_1.id)
    @c1_invoice_3 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c1_invoice_1.id, item_id: @item_1.id)
    c1_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: @c1_invoice_2.id, item_id: @item_1.id)
    c1_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: @c1_invoice_3.id, item_id: @item_1.id)

    @customer_2 = create(:customer)
    @c2_invoice_1 = create(:invoice, status: 1, customer_id: @customer_2.id)
    @c2_invoice_2 = create(:invoice, status: 1, customer_id: @customer_2.id)
    @c2_invoice_3 = create(:invoice, status: 1, customer_id: @customer_2.id)
    @c2_invoice_4 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c2_invoice_1.id, item_id: @item_1.id)
    c2_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: @c2_invoice_2.id, item_id: @item_1.id)
    c2_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: @c2_invoice_3.id, item_id: @item_1.id)
    c2_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: @c2_invoice_4.id, item_id: @item_1.id)

    @customer_3 = create(:customer)
    @c3_invoice_1 = create(:invoice, status: 1, customer_id: @customer_3.id)
    @c3_invoice_2 = create(:invoice, status: 1, customer_id: @customer_3.id)
    @c3_invoice_3 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c3_invoice_1.id, item_id: @item_1.id)
    c3_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: @c3_invoice_2.id, item_id: @item_1.id)
    c3_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: @c3_invoice_3.id, item_id: @item_1.id)

    @customer_4 = create(:customer)
    @c4_invoice_1 = create(:invoice, status: 1, customer_id: @customer_4.id)
    @c4_invoice_2 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c4_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c4_invoice_1.id, item_id: @item_1.id)
    c4_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: @c4_invoice_2.id, item_id: @item_1.id)

    @customer_5 = create(:customer)
    @c5_invoice_1 = create(:invoice, status: 1, customer_id: @customer_5.id)
    @c5_invoice_2 = create(:invoice, status: 1, customer_id: @customer_5.id)
    @c5_invoice_3 = create(:invoice, status: 1, customer_id: @customer_5.id)
    @c5_invoice_4 = create(:invoice, status: 1, customer_id: @customer_5.id)
    @c5_invoice_5 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c5_invoice_1.id, item_id: @item_1.id)
    c5_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: @c5_invoice_2.id, item_id: @item_1.id)
    c5_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: @c5_invoice_3.id, item_id: @item_1.id)
    c5_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: @c5_invoice_4.id, item_id: @item_1.id)
    c5_invoice_item_5 = create(:invoice_item, status: 2, invoice_id: @c5_invoice_5.id, item_id: @item_1.id)

    @customer_6 = create(:customer)
    @c6_invoice_1 = create(:invoice, status: 1, customer_id: @customer_6.id)
    @c6_invoice_2 = create(:invoice, status: 0, customer_id: @customer_6.id, created_at: "2023-10-19 UTC")
    @c6_invoice_3 = create(:invoice, status: 0, customer_id: @customer_6.id, created_at: "2023-10-20 UTC")
    @c6_invoice_4 = create(:invoice, status: 0, customer_id: @customer_6.id, created_at: "2023-10-21 UTC")
    c6_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: @c6_invoice_1.id, item_id: @item_1.id)
    c6_invoice_item_2 = create(:invoice_item, status: 0, invoice_id: @c6_invoice_2.id, item_id: @item_4.id)
    c6_invoice_item_3 = create(:invoice_item, status: 1, invoice_id: @c6_invoice_3.id, item_id: @item_3.id)
    c6_invoice_item_4 = create(:invoice_item, status: 0, invoice_id: @c6_invoice_4.id, item_id: @item_2.id)
    c6_invoice_item_5 = create(:invoice_item, status: 1, invoice_id: @c6_invoice_4.id, item_id: @item_1.id)
  end

  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "#top_5_customers" do
    it "finds the top 5 customers associated with a merchant based on succesful transactions" do
      top_5 = @merchant.top_5_customers
      expect(top_5.first.first_name).to eq(@customer_5.first_name)
    end
  end

  describe "#shippable_items" do
    it "returns item names, invoice id's and invoice creation dates for all items that are ready to be shipped, ordered oldest to newest." do
      ready_to_ship = @merchant.shippable_items
      expect(ready_to_ship.first.name).to eq(@item_4.name)
    end
  end

  describe "#invoices" do
    it "returns all invoices that have at least 1 item that is sold by a merchant" do
      invoices = @merchant.invoices
      expect([invoices.first.id, invoices.last.id]).to eq([@c1_invoice_1.id, @c6_invoice_4.id])
    end
  end

  describe "#top_5_items" do
    it "returns the top 5 items by revenue for a merchant" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_2)
      invoice_4 = create(:invoice, customer: customer_2)

      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_3 = create(:item, merchant: merchant_1)
      item_4 = create(:item, merchant: merchant_1)
      item_5 = create(:item, merchant: merchant_1)
      item_6 = create(:item, merchant: merchant_1)
      item_7 = create(:item, merchant: merchant_1)
      item_8 = create(:item, merchant: merchant_2)
      item_9 = create(:item, merchant: merchant_2)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1, unit_price: 500, status: 1)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 1, unit_price: 1000, status: 1)
      invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 3, unit_price: 1000, status: 1)
      invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_2, quantity: 2, unit_price: 1500, status: 1)
      invoice_item_5 = create(:invoice_item, item: item_4, invoice: invoice_2, quantity: 10, unit_price: 40, status: 1)
      invoice_item_6 = create(:invoice_item, item: item_5, invoice: invoice_1, quantity: 1, unit_price: 1000, status: 1)
      invoice_item_7 = create(:invoice_item, item: item_6, invoice: invoice_1, quantity: 7, unit_price: 500, status: 1)
      invoice_item_8 = create(:invoice_item, item: item_7, invoice: invoice_1, quantity: 4, unit_price: 1200, status: 1)
      invoice_item_9 = create(:invoice_item, item: item_8, invoice: invoice_3, quantity: 10, unit_price: 1200, status: 1)
      invoice_item_10 = create(:invoice_item, item: item_9, invoice: invoice_4, quantity: 7, unit_price: 1000, status: 1)
      expect(merchant_1.top_5_items).to eq([item_7, item_2, item_6, item_3, item_5])
    end
  end
end
