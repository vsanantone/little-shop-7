require 'rails_helper' 

RSpec.describe "Merchants Dashboard" do 
  before(:each) do 
    @merchant_1 = create(:merchant)

    item = create(:item, merchant_id: @merchant_1.id)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    c1_invoice_1 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_2 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_3 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c2_invoice_1 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_2 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_3 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_4 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c3_invoice_1 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_2 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_3 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c4_invoice_1 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c4_invoice_2 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c5_invoice_1 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_2 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_3 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_4 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_5 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c6_invoice_1 = create(:invoice, status: 1, customer_id: @customer_6.id)

    c1_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c1_invoice_1.id, item_id: item.id)
    c1_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c1_invoice_2.id, item_id: item.id)
    c1_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c1_invoice_3.id, item_id: item.id)

    c2_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c2_invoice_1.id, item_id: item.id)
    c2_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c2_invoice_2.id, item_id: item.id)
    c2_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c2_invoice_3.id, item_id: item.id)
    c2_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c2_invoice_4.id, item_id: item.id)

    c3_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c3_invoice_1.id, item_id: item.id)
    c3_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c3_invoice_2.id, item_id: item.id)
    c3_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c3_invoice_3.id, item_id: item.id)

    c4_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c4_invoice_1.id, item_id: item.id)
    c4_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c4_invoice_2.id, item_id: item.id)

    c5_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c5_invoice_1.id, item_id: item.id)
    c5_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c5_invoice_2.id, item_id: item.id)
    c5_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c5_invoice_3.id, item_id: item.id)
    c5_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c5_invoice_4.id, item_id: item.id)
    c5_invoice_item_5 = create(:invoice_item, status: 2, invoice_id: c5_invoice_5.id, item_id: item.id)

    c6_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c6_invoice_1.id, item_id: item.id)
  end
  describe "visiting the merchant dashboard" do 
    it "displays the name of my merchant" do 
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end
    it "displays links to my merchant items index and my merchant invoices index." do 
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("My Items", :href => "/merchants/#{@merchant_1.id}/items")
      expect(page).to have_link("My Invoices", :href => "/merchants/#{@merchant_1.id}/invoices")
    end
    it "displays the name and number of transactions for my merchants top 5 customers." do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content("Top 5 Customers:")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} Transactions: 5")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name} Transactions: 4")
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} Transactions: 3")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name} Transactions: 3")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} Transactions: 2")
    end
  end
end 