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
    click_link(merchant.name)

    expect(current_path).to eq(admin_merchant_path(merchant.id))

    expect(page).to have_content(merchant.name)
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