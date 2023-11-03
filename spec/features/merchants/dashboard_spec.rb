require 'rails_helper' 

RSpec.describe "Merchants Dashboard" do 
  before(:each) do 
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)
    
    
    @customer_1 = create(:customer)
    c1_invoice_1 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_2 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_3 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c1_invoice_1.id, item_id: @item_1.id)
    c1_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c1_invoice_2.id, item_id: @item_1.id)
    c1_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c1_invoice_3.id, item_id: @item_1.id)
    
    @customer_2 = create(:customer)
     c2_invoice_1 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_2 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_3 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_4 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c2_invoice_1.id, item_id: @item_1.id)
    c2_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c2_invoice_2.id, item_id: @item_1.id)
    c2_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c2_invoice_3.id, item_id: @item_1.id)
    c2_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c2_invoice_4.id, item_id: @item_1.id)

    @customer_3 = create(:customer)
    c3_invoice_1 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_2 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_3 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c3_invoice_1.id, item_id: @item_1.id)
    c3_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c3_invoice_2.id, item_id: @item_1.id)
    c3_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c3_invoice_3.id, item_id: @item_1.id)
    

    @customer_4 = create(:customer)
    c4_invoice_1 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c4_invoice_2 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c4_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c4_invoice_1.id, item_id: @item_1.id)
    c4_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c4_invoice_2.id, item_id: @item_1.id)

    @customer_5 = create(:customer)
    c5_invoice_1 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_2 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_3 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_4 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_5 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c5_invoice_1.id, item_id: @item_1.id)
    c5_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c5_invoice_2.id, item_id: @item_1.id)
    c5_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c5_invoice_3.id, item_id: @item_1.id)
    c5_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c5_invoice_4.id, item_id: @item_1.id)
    c5_invoice_item_5 = create(:invoice_item, status: 2, invoice_id: c5_invoice_5.id, item_id: @item_1.id)

    @customer_6 = create(:customer)
    c6_invoice_1 = create(:invoice, status: 1, customer_id: @customer_6.id)
    @c6_invoice_2 = create(:invoice, status: 0, customer_id: @customer_6.id)
    @c6_invoice_3 = create(:invoice, status: 0, customer_id: @customer_6.id)
    @c6_invoice_4 = create(:invoice, status: 0, customer_id: @customer_6.id)
    c6_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c6_invoice_1.id, item_id: @item_1.id)
    c6_invoice_item_2 = create(:invoice_item, status: 0, invoice_id: @c6_invoice_2.id, item_id: @item_4.id)
    c6_invoice_item_3 = create(:invoice_item, status: 1, invoice_id: @c6_invoice_3.id, item_id: @item_3.id)
    c6_invoice_item_4 = create(:invoice_item, status: 0, invoice_id: @c6_invoice_4.id, item_id: @item_2.id)
    c6_invoice_item_5 = create(:invoice_item, status: 1, invoice_id: @c6_invoice_4.id, item_id: @item_1.id)
  end
  describe "visiting the merchant dashboard" do 
    it "displays the name of my merchant" do 
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)
    end
    it "displays links to my merchant items index and my merchant invoices index." do 
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_link("My Items", :href => "/merchants/#{@merchant.id}/items")
      expect(page).to have_link("My Invoices", :href => "/merchants/#{@merchant.id}/invoices")
    end
    it "displays the name and number of transactions for my merchants top 5 customers." do
      visit "/merchants/#{@merchant.id}/dashboard"
      within "#top_5" do
        expect(page).to have_content("Top 5 Customers:")
        expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} Transactions: 5")
        expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name} Transactions: 4")
        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} Transactions: 3")
        expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name} Transactions: 3")
        expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} Transactions: 2")
      end
    end
    describe "section 'Items Ready to Ship'" do 
      it "lists the names of all items that have been ordered and have not been shipped and their associated invoice ID" do 
        visit "/merchants/#{@merchant.id}/dashboard"

        within "#ready_to_ship" do
          expect(page).to have_content("#{@item_4.name} - Invoice # #{@c6_invoice_2.id}, #{@c6_invoice_2.created_at}")
          expect(page).to have_content("#{@item_3.name} - Invoice # #{@c6_invoice_3.id}, #{@c6_invoice_3.created_at}")
          expect(page).to have_content("#{@item_1.name} - Invoice # #{@c6_invoice_4.id}, #{@c6_invoice_4.created_at}")
          expect(page).to have_content("#{@item_2.name} - Invoice # #{@c6_invoice_4.id}, #{@c6_invoice_4.created_at}")
        end
      end 
      it 'links each items invoice ID to my merchants invoice show page' do 
        visit "/merchants/#{@merchant.id}/dashboard"

        within "#ready_to_ship" do
          click_link "#{@c6_invoice_2.id}"
        end
        expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@c6_invoice_2.id}")
      end

      it 'lists each invoices creation date and lists items from oldest to newest' do
        visit "/merchants/#{@merchant.id}/dashboard"
        save_and_open_page
        this = @item_4.name
        that = @item_2.name
        within "#ready_to_ship" do
          expect(this).to appear_before(that)
          expect(page).to have_content("Items Ready to Ship")
          expect(page).to have_content("#{@item_4.name} - Invoice # #{@c6_invoice_2.id}, #{@c6_invoice_2.created_at}")
          expect(page).to have_content("#{@item_3.name} - Invoice # #{@c6_invoice_3.id}, #{@c6_invoice_3.created_at}")
          expect(page).to have_content("#{@item_1.name} - Invoice # #{@c6_invoice_4.id}, #{@c6_invoice_4.created_at}")
          expect(page).to have_content("#{@item_2.name} - Invoice # #{@c6_invoice_4.id}, #{@c6_invoice_4.created_at}")
        end
      end
    end   
  end
end 