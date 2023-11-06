require "rails_helper"

RSpec.describe "Merchant Items Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id, status: 0)
    @item_4 = create(:item, merchant_id: @merchant_1.id, status: 0)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)
    @item_7 = create(:item, merchant_id: @merchant_3.id)
  end

  describe "US6 - index page" do
    it "displays list of the names of all my items and not items of other merchants" do
      visit "/merchants/#{@merchant_1.id}/items"

      within "#merchants-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_4.name)
      end

      expect(page).to have_no_content(@item_5.name)
      expect(page).to have_no_content(@item_6.name)
      expect(page).to have_no_content(@item_7.name)
    end
  end
end
