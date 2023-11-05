require "rails_helper"

RSpec.describe "Admin Invoice Show" do
  before(:each) do
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

    @item1 = create(:item)
    @item2 = create(:item)
    @item3 = create(:item)
    @item4 = create(:item)
    @item5 = create(:item)
    @item6 = create(:item)
    @item7 = create(:item)
    @item8 = create(:item)
    # @item9 = create(:item)

    @invoice_item_1 = create(:invoice_item, status: 0, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item_2 = create(:invoice_item, status: 0, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item_3 = create(:invoice_item, status: 0, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item_4 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item4.id)
    @invoice_item_5 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item5.id)
    @invoice_item_6 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item6.id)
    @invoice_item_7 = create(:invoice_item, status: 0, invoice_id: @invoice8.id, item_id: @item7.id)
    @invoice_item_8 = create(:invoice_item, status: 0, invoice_id: @invoice11.id, item_id: @item8.id)

  end

  it "invoice show page has information about invoice" do
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Customer Name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
  end

  it "Show Invoice Item Information" do
    visit "/admin/invoices/#{@invoice1.id}"
    # save_and_open_page
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Customer Name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to have_content("#{@item1.name}")
    expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
    expect(page).to have_content("Price: $#{@invoice_item_1.unit_price_show}")
    expect(page).to have_content("Status: #{@invoice_item_1.status}")
  end

  it "Show Invoice Item Information - elaborated" do
    visit "/admin/invoices/#{@invoice4.id}"
    # save_and_open_page
    expect(page).to have_content("Invoice ##{@invoice4.id}")
    expect(page).to have_content("Customer Name: #{@invoice4.customer.first_name} #{@invoice4.customer.last_name}")
    expect(page).to have_content("Status: #{@invoice4.status}")
    expect(page).to have_content("Created on: #{@invoice4.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to have_content("#{@item4.name}")
    expect(page).to have_content("Quantity: #{@invoice_item_4.quantity}")
    expect(page).to have_content("Price: $#{@invoice_item_4.unit_price_show}")
    expect(page).to have_content("Status: #{@invoice_item_4.status}")

    expect(page).to have_content("#{@item5.name}")
    expect(page).to have_content("Quantity: #{@invoice_item_5.quantity}")
    expect(page).to have_content("Price: $#{@invoice_item_5.unit_price_show}")
    expect(page).to have_content("Status: #{@invoice_item_5.status}")

    expect(page).to have_content("#{@item6.name}")
    expect(page).to have_content("Quantity: #{@invoice_item_6.quantity}")
    expect(page).to have_content("Price: $#{@invoice_item_6.unit_price_show}")
    expect(page).to have_content("Status: #{@invoice_item_6.status}")

    expect(page).to_not have_content("#{@item1.name}")
    expect(page).to_not have_content("#{@item2.name}")
    expect(page).to_not have_content("#{@item3.name}")
    expect(page).to_not have_content("#{@item7.name}")
    expect(page).to_not have_content("#{@item8.name}")
  end

  it "Show total revenue from invoice" do
    visit "/admin/invoices/#{@invoice1.id}"
    
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Customer Name: #{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Total Revenue: $#{@invoice1.total_revenue}")

    expect(page).to have_content("#{@item1.name}")
    expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
    expect(page).to have_content("Price: $#{@invoice_item_1.unit_price_show}")
    expect(page).to have_content("Status: #{@invoice_item_1.status}")
  end
end