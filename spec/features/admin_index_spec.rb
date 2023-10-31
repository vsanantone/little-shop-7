require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it "displays a header indicating the user is on the admin dashboard" do
  
    # 19. Admin Dashboard
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit "/admins" #admin_path
    # Then I see a header indicating that I am on the admin dashboard
    expect(page).to have_content("Welcome to the Admin Dashboard")
  end
end