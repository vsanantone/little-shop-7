require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  it "displays all merchant names" do
    merchants = create_list(:merchant, 10)
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit admin_merchants_path
    # Then I see the name of each merchant in the system`
    merchants.each do |merchant|
      expect(page).to have_content(merchant.name)
    end
  end

  it "links to admin show page of each merchant" do
    merchant = create(:merchant)
    # As an admin,
    # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
    visit admin_merchants_path
    click_link(merchant.name)

    # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
    expect(current_path).to eq(admin_merchant_path(merchant.id))
    # And I see the name of that merchant
    expect(page).to have_content(merchant.name)
  end
end