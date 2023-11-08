require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  before :each do
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
  end
  it "displays all merchant names" do
    merchants = create_list(:merchant, 10)

    visit admin_merchants_path

    merchants.each do |merchant|
      expect(page).to have_content(merchant.name)
    end
  end

  it "links to admin show page of each merchant" do
    merchant = create(:merchant)

    visit admin_merchants_path

    click_link(merchant.name)

    expect(current_path).to eq(admin_merchant_path(merchant.id))

    expect(page).to have_content(merchant.name)
  end


  it "Show to top merchants according to revenue" do
    visit "/admin/merchants"

    expect(page).to have_content("Top Five Merchants")
    expect(page).to have_content("#{@merchant3.name} $90.00")
    expect(page).to have_content("#{@merchant1.name} $38.00")
    expect(page).to have_content("#{@merchant4.name} $34.00")
    expect(page).to have_content("#{@merchant2.name} $6.00")
    
    within("div#top_merchants") do
      expect(@merchant3.name).to appear_before(@merchant1.name)
      expect(@merchant1.name).to appear_before(@merchant4.name)
      expect(@merchant4.name).to appear_before(@merchant2.name)
      
      #Has no Successful transactions
      expect(page).to_not have_content(@merchant5.name)
      # Has no transactions
      expect(page).to_not have_content(@merchant6.name)
    end 

    @transaction17.result = 1
    @transaction17.save

    visit "/admin/merchants"

    within("div#top_merchants") do
      expect(page).to have_content(@merchant5.name)
    end
  end
end