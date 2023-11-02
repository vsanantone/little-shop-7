require 'rails_helper'

RSpec.describe "Admin Dashboard" do
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
    @transaction17 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction18 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  end
  it "displays a header indicating the user is on the admin dashboard" do
  
    # 19. Admin Dashboard
    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    visit "/admin"
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "display a link to the Admin Merchants & Invoice Index page" do
    # 20. Admin Dashboard Links
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit "/admin"

    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link("Admin Merchant's Index")
    click_link("Admin Merchant's Index")
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Admin Merchants")
    # And I see a link to the admin invoices index (/admin/invoices)
    visit "/admin"
    expect(page).to have_link("Admin Invoice's Index")
    click_link("Admin Invoice's Index")
    expect(current_path).to eq("/admin/invoices")
    expect(page).to have_content("Admin Invoices")
  end

  it "Dashboard Statistics - Top Customer" do
    visit "/admin"
    # save_and_open_page
    expect(page).to have_content("Welcome to the Admin Dashboard")
    within("div#statistics") do
      expect(page).to have_content("Top Customers")
      expect(@customer3.first_name).to appear_before(@customer2.first_name)
      expect(@customer1.first_name).to_not appear_before(@customer3.first_name)
      expect(@customer1.first_name).to appear_before(@customer4.first_name)
      expect(@customer4.first_name).to appear_before(@customer2.first_name)
      expect(@customer5.first_name).to_not appear_before(@customer2.first_name)
    end
  end

  it "Dashboard - Incomplete Invoices" do
    visit "/admin"

    expect(page).to have_content("Welcome to the Admin Dashboard")
    
    within("div#invoices") do
      expect(page).to have_content("Incomplete Invoices")
      
      expect(page).to have_link("Invoice ID: #{@invoice5.id}")
      expect(page).to have_link("Invoice ID: #{@invoice6.id}")
      expect(page).to have_link("Invoice ID: #{@invoice9.id}")
      expect(page).to have_link("Invoice ID: #{@invoice14.id}")
    end

    click_link("Invoice ID: #{@invoice5.id}")
    expect(current_path).to eq("/admin/invoices/#{@invoice5.id}")
    expect(page).to have_content("Invoice ##{@invoice5.id}")
    expect(page).to have_content("Customer Name: #{@invoice5.customer.first_name} #{@invoice5.customer.last_name}")
    expect(page).to have_content("Status: #{@invoice5.status}")
  end

  it "Dashboard - Incomplete Invoices - Ordered with Date" do
    visit "/admin"

    expect(page).to have_content("Welcome to the Admin Dashboard")
    
    within("div#invoices") do
      expect(page).to have_content("Incomplete Invoices")
      
      expect(page).to have_link("Invoice ID: #{@invoice5.id}")
      expect(page).to have_link("Invoice ID: #{@invoice6.id}")
      expect(page).to have_link("Invoice ID: #{@invoice9.id}")
      expect(page).to have_link("Invoice ID: #{@invoice14.id}")
    end

    expect("Invoice ID: #{@invoice14.id}").to appear_before("Invoice ID: #{@invoice9.id}")
    expect("Invoice ID: #{@invoice9.id}").to appear_before("Invoice ID: #{@invoice6.id}")
    expect("Invoice ID: #{@invoice6.id}").to appear_before("Invoice ID: #{@invoice5.id}")
  end
end