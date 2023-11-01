require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  it "" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit "/admin/merchants"
    # Then I see the name of each merchant in the system`
    expect(page).to have_content()
    
  end
end