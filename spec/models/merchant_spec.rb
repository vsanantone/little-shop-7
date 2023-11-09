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

  describe "#top_five_merchants" do 
    it "returns the 5 merchants with highest revenue and their total revenue generated" do
      @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
      @invoice1 = @customer1.invoices.create!(status: 1)
      @transaction1 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction2 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction3 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction4 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
  
      @customer2 = Customer.create!(first_name: "Mary", last_name: "Jane")
      @invoice2 = @customer2.invoices.create!(status: 1)
      @invoice3 = @customer2.invoices.create!(status: 2)
      @transaction5 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction6 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction7 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer3 = Customer.create!(first_name: "Johnny", last_name: "Bowflex")
      @invoice4 = @customer3.invoices.create!(status:1)
      @invoice5 = @customer3.invoices.create!(status:0)
      @invoice6 = @customer3.invoices.create!(status:0)
      @invoice7 = @customer3.invoices.create!(status:2)
      @transaction8 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction9 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction10 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction11 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction12 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer4 = Customer.create!(first_name: "Alvin", last_name: "Setter")
      @invoice8 = @customer4.invoices.create!(status:1)
      @invoice9 = @customer4.invoices.create!(status:0)
      @invoice10 = @customer4.invoices.create!(status:2)
      @transaction13 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction14 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction15 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction16 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer5 = Customer.create!(first_name: "Masison", last_name: "House")
      @invoice11 = @customer5.invoices.create!(status: 1)
      @invoice12 = @customer5.invoices.create!(status: 2)
      @invoice13 = @customer5.invoices.create!(status: 2)
      @invoice14 = @customer5.invoices.create!(status: 0)
      @transaction17 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0)
      @transaction18 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0)
  
      @merchant1 = create(:merchant, name: "m1")
      @merchant2 = create(:merchant, name: "m2")
      @merchant3 = create(:merchant, name: "m3")
      @merchant4 = create(:merchant, name: "m4")
      @merchant5 = create(:merchant, name: "m5")
      @merchant6 = create(:merchant, name: "m6")
  
  
      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item4 = create(:item, merchant_id: @merchant3.id)
      @item5 = create(:item, merchant_id: @merchant3.id)
      @item6 = create(:item, merchant_id: @merchant4.id)
      @item7 = create(:item, merchant_id: @merchant4.id)
      @item8 = create(:item, merchant_id: @merchant5.id)
      
      @invoice_item_1 = create(:invoice_item, status: 0, unit_price: 500, invoice_id: @invoice1.id, item_id: @item1.id)
      @invoice_item_2 = create(:invoice_item, status: 0, unit_price: 300,invoice_id: @invoice2.id, item_id: @item2.id)
      @invoice_item_3 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice2.id, item_id: @item3.id)
      @invoice_item_4 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice4.id, item_id: @item4.id)
      @invoice_item_5 = create(:invoice_item, status: 0, unit_price: 500,invoice_id: @invoice4.id, item_id: @item5.id)
      @invoice_item_6 = create(:invoice_item, status: 0, unit_price: 200,invoice_id: @invoice4.id, item_id: @item6.id)
      @invoice_item_7 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice8.id, item_id: @item7.id)
      @invoice_item_8 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice11.id, item_id: @item8.id)

    expect(Merchant.top_five_merchants.sort).to match([@merchant1, @merchant2, @merchant3, @merchant4])
    
    @transaction17.result = 1
    @transaction17.save
    expect(Merchant.top_five_merchants.sort).to match([@merchant1, @merchant2, @merchant3, @merchant4, @merchant5])
    
    end
  end
  describe "#best_day" do 
    it "finds the date a merchant earned their highest revenue" do 
      @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
      @invoice1 = @customer1.invoices.create!(status: 1, created_at: "2023-10-01 UTC")
      @transaction1 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction2 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction3 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
      @transaction4 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
  
      @customer2 = Customer.create!(first_name: "Mary", last_name: "Jane")
      @invoice2 = @customer2.invoices.create!(status: 1, created_at: "2023-10-02 UTC")
      @invoice3 = @customer2.invoices.create!(status: 2, created_at: "2023-10-02 UTC")
      @transaction5 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction6 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction7 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer3 = Customer.create!(first_name: "Johnny", last_name: "Bowflex")
      @invoice4 = @customer3.invoices.create!(status:1, created_at: "2023-10-03 UTC")
      @invoice5 = @customer3.invoices.create!(status:0, created_at: "2023-10-03 UTC")
      @invoice6 = @customer3.invoices.create!(status:0, created_at: "2023-10-03 UTC")
      @invoice7 = @customer3.invoices.create!(status:2, created_at: "2023-10-03 UTC")
      @transaction8 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction9 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction10 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction11 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction12 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer4 = Customer.create!(first_name: "Alvin", last_name: "Setter")
      @invoice8 = @customer4.invoices.create!(status:1, created_at: "2023-10-04 UTC")
      @invoice9 = @customer4.invoices.create!(status:0, created_at: "2023-10-04 UTC")
      @invoice10 = @customer4.invoices.create!(status:2, created_at: "2023-10-04 UTC")
      @transaction13 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction14 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction15 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
      @transaction16 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  
      @customer5 = Customer.create!(first_name: "Masison", last_name: "House")
      @invoice11 = @customer5.invoices.create!(status: 1, created_at: "2023-10-05 UTC")
      @invoice12 = @customer5.invoices.create!(status: 2, created_at: "2023-10-05 UTC")
      @invoice13 = @customer5.invoices.create!(status: 2, created_at: "2023-10-05 UTC")
      @invoice14 = @customer5.invoices.create!(status: 0, created_at: "2023-10-05 UTC")
      @transaction17 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0, created_at: "2023-10-05 UTC")
      @transaction18 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0, created_at: "2023-10-05 UTC")
  
      @merchant1 = create(:merchant, name: "m1")
      @merchant2 = create(:merchant, name: "m2")
      @merchant3 = create(:merchant, name: "m3")
      @merchant4 = create(:merchant, name: "m4")
      @merchant5 = create(:merchant, name: "m5")
      @merchant6 = create(:merchant, name: "m6")
  
  
      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item4 = create(:item, merchant_id: @merchant3.id)
      @item5 = create(:item, merchant_id: @merchant3.id)
      @item6 = create(:item, merchant_id: @merchant4.id)
      @item7 = create(:item, merchant_id: @merchant4.id)
      @item8 = create(:item, merchant_id: @merchant5.id)
      
      @invoice_item_1 = create(:invoice_item, status: 0, unit_price: 500, invoice_id: @invoice1.id, item_id: @item1.id)
      @invoice_item_2 = create(:invoice_item, status: 0, unit_price: 300,invoice_id: @invoice2.id, item_id: @item2.id)
      @invoice_item_3 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice2.id, item_id: @item3.id)
      @invoice_item_4 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice4.id, item_id: @item4.id)
      @invoice_item_5 = create(:invoice_item, status: 0, unit_price: 500,invoice_id: @invoice4.id, item_id: @item5.id)
      @invoice_item_6 = create(:invoice_item, status: 0, unit_price: 200,invoice_id: @invoice4.id, item_id: @item6.id)
      @invoice_item_7 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice8.id, item_id: @item7.id)
      @invoice_item_8 = create(:invoice_item, status: 0, unit_price: 100,invoice_id: @invoice11.id, item_id: @item8.id)

      expect(@merchant1.best_day.order_date.strftime("%A, %B %d, %Y")).to eq("Sunday, October 01, 2023")
    end
  end
end
