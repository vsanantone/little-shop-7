require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  before :each do
    # @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    # @invoice1 = Invoice.create!(status: 1, customer_id: "#{@customer1.id}")
    # @transaction1 = Transaction.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
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
    # require 'pry'; binding.pry
    
    expect(page).to have_content("Welcome to the Admin Dashboard")
    expect(page).to have_content("Top Customers")
  end
end