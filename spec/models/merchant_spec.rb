require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "instance methods" do
    before(:each) do 
      load_test_data
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
  end

  describe "class methods" do
    describe "#status" do
      it "will return all merchants with a given status" do
        true_merchants = create_list(:merchant, 3, enabled: true)
        false_merchants = create_list(:merchant, 3)

        expect(Merchant.merchant_status(true)).to eq(true_merchants)
        expect(Merchant.merchant_status(false)).to eq(false_merchants)
      end
    end
  end

  describe "#invoices" do
    it "returns all invoices that have at least 1 item that is sold by a merchant" do
      load_test_data
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
  describe "#top_merchant_best_day" do 
    it "returns the date of the top merchant earned their highest revenue." do
    merchant1 = create(:merchant, name: "Doug", enabled: true)
    merchant2 = create(:merchant, enabled: true)
    merchant3 = create(:merchant, enabled: true)
    item1 = create(:item, unit_price: 100, merchant: merchant1)
    item2 = create(:item, unit_price: 10, merchant: merchant2)
    item3 = create(:item, unit_price: 1, merchant: merchant3)
    invoice1 = create(:invoice, status: 0, created_at: "2023-10-19 UTC")
    invoice2 = create(:invoice, status: 1, created_at: "2023-10-19 UTC")
    invoice3 = create(:invoice, status: 2, created_at: "2023-10-19 UTC")
    invoice4 = create(:invoice, status: 0, created_at: "2023-10-20 UTC")
    invoice5 = create(:invoice, status: 1, created_at: "2023-10-20 UTC")
    invoice6 = create(:invoice, status: 2, created_at: "2023-10-20 UTC")
    invoice7 = create(:invoice, status: 0, created_at: "2023-10-21 UTC")
    invoice8 = create(:invoice, status: 1, created_at: "2023-10-21 UTC")
    invoice9 = create(:invoice, status: 2, created_at: "2023-10-21 UTC")
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 100, status: 2)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice5, quantity: 10, status: 2)
    invoice_item3 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 1, status: 2)
    invoice_item4 = create(:invoice_item, item: item1, invoice: invoice3, quantity: 100, status: 0)
    invoice_item5 = create(:invoice_item, item: item2, invoice: invoice6, quantity: 100, status: 0)
    invoice_item6 = create(:invoice_item, item: item3, invoice: invoice9, quantity: 100, status: 0)
    invoice_item7 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    invoice_item8 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    invoice_item9 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    transaction1 = create(:transaction, invoice: invoice2, result:1)
    transaction2 = create(:transaction, invoice: invoice5, result:1)
    transaction3 = create(:transaction, invoice: invoice8, result:1)
    transaction4 = create(:transaction, invoice: invoice3, result:0)
    transaction5 = create(:transaction, invoice: invoice6, result:0)
    transaction6 = create(:transaction, invoice: invoice9, result:0)
    transaction7 = create(:transaction, invoice: invoice1, result:0)
    transaction8 = create(:transaction, invoice: invoice4, result:0)
    transaction9 = create(:transaction, invoice: invoice7, result:0)

    expect(Merchant.top_merchant_best_day.order_date).to eq("2023-10-19 UTC")
    end
  end
end
