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

  it "can enable/disable a merchant with a button click " do
    merchants = create_list(:merchant, 3)
    # 27. Admin Merchant Enable/Disable
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit admin_merchants_path
    # Then next to each merchant name I see a button to disable or enable that merchant.
    merchants.each do |merchant|
      within("#merchant-#{merchant.id}") do
        expect(page).to have_content(merchant.name) #either class or section id in the view
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
      end
    end
    # When I click this button
    within("#merchant-#{merchants.first.id}") do
      click_button("Enable")
    end
    # Then I am redirected back to the admin merchants index
    expect(current_path).to eq(admin_merchants_path)
    # And I see that the merchant's status has changed
    within("#merchant-#{merchants.first.id}") do
      expect(page).to have_content(merchants.first.name)
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")
      click_button("Disable")
      expect(page).to have_button("Enable")
    end
  end
end