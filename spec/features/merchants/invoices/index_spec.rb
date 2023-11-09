require "rails_helper"

RSpec.describe "Merchants Invoice Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    item_1 = create(:item, merchant_id: @merchant_1.id)
    item_2 = create(:item, merchant_id: @merchant_2.id)
    item_3 = create(:item, merchant_id: @merchant_3.id)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
    @invoice_6 = create(:invoice)
    @invoice_7 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: item_3.id)
    invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: item_2.id)
    invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: item_2.id)
    invoice_item_5 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: item_3.id)
    invoice_item_6 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: item_1.id)
    invoice_item_7 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: item_1.id)
    invoice_item_8 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: item_3.id)
    invoice_item_9 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: item_2.id)
    invoice_item_10 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: item_2.id)
    invoice_item_11 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: item_1.id)
    invoice_item_12 = create(:invoice_item, invoice_id: @invoice_6.id, item_id: item_3.id)
    invoice_item_13 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: item_1.id)
    invoice_item_14 = create(:invoice_item, invoice_id: @invoice_7.id, item_id: item_3.id)
  end

  describe "visiting the merchant invoices index (/merchants/:merchant_id/invoices)" do
    it "displays all the invoices that include at least on of my merchant's items" do
      visit "/merchants/#{@merchant_1.id}/invoices"
      expect(page).to have_content("My Invoices")
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_3.id}")
      expect(page).to have_content("Invoice ##{@invoice_4.id}")
      expect(page).to have_content("Invoice ##{@invoice_6.id}")
      expect(page).to have_content("Invoice ##{@invoice_7.id}")
    end
    it "Each Invoice ID displayed is a link to that Invoice's show page" do
      visit "/merchants/#{@merchant_1.id}/invoices"

      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_4.id}")
      expect(page).to have_link("#{@invoice_6.id}")
      expect(page).to have_link("#{@invoice_7.id}")

      click_link "#{@invoice_1.id}"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    end
  end
end
