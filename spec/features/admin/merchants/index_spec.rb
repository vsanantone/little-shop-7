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

  describe "Top Merchant's Best Day" do 
    it "displays a label showing the top merchant, and the date they earned the most revenue" do
    merchant1 = create(:merchant, name: "Doug", enabled: true)
    merchant2 = create(:merchant, enabled: true)
    merchant3 = create(:merchant, enabled: true)
    item1 = create(:item, unit_price: 100, merchant: merchant1)
    item2 = create(:item, unit_price: 10, merchant: merchant2)
    item3 = create(:item, unit_price: 1, merchant: merchant3)
    invoice1 = create(:invoice, status: 0, created_at: "2023-10-19 UTC")
    invoice2 = create(:invoice, status: 1, created_at: "2023-10-19 UTC")
    invoice3 = create(:invoice, status: 2, created_at: "2023-10-19 UTC")
    invoice4 = create(:invoice, status: 0, created_at: "2023-10-20 UTC")
    invoice5 = create(:invoice, status: 1, created_at: "2023-10-20 UTC")
    invoice6 = create(:invoice, status: 2, created_at: "2023-10-20 UTC")
    invoice7 = create(:invoice, status: 0, created_at: "2023-10-21 UTC")
    invoice8 = create(:invoice, status: 1, created_at: "2023-10-21 UTC")
    invoice9 = create(:invoice, status: 2, created_at: "2023-10-21 UTC")
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 100, status: 2)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice5, quantity: 10, status: 2)
    invoice_item3 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 1, status: 2)
    invoice_item4 = create(:invoice_item, item: item1, invoice: invoice3, quantity: 100, status: 0)
    invoice_item5 = create(:invoice_item, item: item2, invoice: invoice6, quantity: 100, status: 0)
    invoice_item6 = create(:invoice_item, item: item3, invoice: invoice9, quantity: 100, status: 0)
    invoice_item7 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    invoice_item8 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    invoice_item9 = create(:invoice_item, item: item3, invoice: invoice8, quantity: 10, status: 0)
    transaction1 = create(:transaction, invoice: invoice2, result:1)
    transaction2 = create(:transaction, invoice: invoice5, result:1)
    transaction3 = create(:transaction, invoice: invoice8, result:1)
    transaction4 = create(:transaction, invoice: invoice3, result:0)
    transaction5 = create(:transaction, invoice: invoice6, result:0)
    transaction6 = create(:transaction, invoice: invoice9, result:0)
    transaction7 = create(:transaction, invoice: invoice1, result:0)
    transaction8 = create(:transaction, invoice: invoice4, result:0)
    transaction9 = create(:transaction, invoice: invoice7, result:0)
    visit admin_merchants_path
    save_and_open_page
    end
  end
end
