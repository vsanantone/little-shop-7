require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it "displays a header indicating the user is on the admin dashboard" do
  
    # 19. Admin Dashboard
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit "/admin" #admin_path
    # Then I see a header indicating that I am on the admin dashboard
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end
 it "display a link to the Admin Merchants & Invoice Index page" do
    # 20. Admin Dashboard Links
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit "/admin" #admin_path

    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link("Admin Merchant's Index")
    click_link("Admin Merchant's Index")
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Admin Merchants")
    # And I see a link to the admin invoices index (/admin/invoices)
    visit "/admin" #admin_path
    expect(page).to have_link("Admin Invoice's Index")
    click_link("Admin Invoice's Index")
    expect(current_path).to eq("/admin/invoices")
    expect(page).to have_content("Admin Invoices")

  end
end