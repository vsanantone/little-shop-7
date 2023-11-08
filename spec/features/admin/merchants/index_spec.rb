require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  before :each do

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
    
    within("#merchant-#{merchant.id}") do
      click_link(merchant.name)

    # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
    expect(current_path).to eq(admin_merchant_path(merchant.id))
    end
    visit admin_merchant_path(merchant.id)
    # And I see the name of that merchant
    expect(page).to have_content(merchant.name)
  end

  it "can enable/disable a merchant with a button click " do
    merchants = create_list(:merchant, 3)
    enabled_merchants = create_list(:merchant, 3, enabled: true)
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
        click_button("Enable")
      end
      expect(current_path).to eq(admin_merchants_path)
    end
    
    visit admin_merchants_path

    enabled_merchants.each do |merchant|
      within("#merchant-#{merchant.id}") do
        expect(page).to have_content(merchant.name)
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
        click_button("Disable")
      end
    expect(current_path).to eq(admin_merchants_path)
    end
  end

  it "divides merchants into enabled/disabled sections " do
    true_merchants = create_list(:merchant, 2, enabled: true)
    false_merchants = create_list(:merchant, 2)

    # 28. Admin Merchants Grouped by Status
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit admin_merchants_path
    # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
    within("#enabled_merchants") do
      expect(page).to have_content("Enabled Merchants")
    # And I see that each Merchant is listed in the appropriate section
      expect(page).to have_content(true_merchants.first.name)
      expect(page).to have_content(true_merchants.last.name)
      expect(page).to_not have_content(false_merchants.first.name)
      expect(page).to_not have_content(false_merchants.last.name)
    end

    within("#disabled_merchants") do
      expect(page).to have_content("Disabled Merchants")
      expect(page).to have_content(false_merchants.first.name)
      expect(page).to have_content(false_merchants.last.name)
      expect(page).to_not have_content(true_merchants.first.name)
      expect(page).to_not have_content(true_merchants.last.name)
    end
  end
  
  it "Create new merchant" do
    visit "/admin/merchants"

    expect(page).to have_content("Admin Merchants")
    expect(page).to have_link("Create a merchant")

    click_link("Create a merchant")
    expect(current_path).to eq("/admin/merchants/new")

    expect(page).to have_content("Create a New Merchant")
    expect(page).to have_content("Add your merchant name and that's it!")

    fill_in(:name, with: "Belongea Boulangerie")
    click_button("Create Merchant")

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Belongea Boulangerie")
  end
end