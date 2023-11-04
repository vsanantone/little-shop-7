require "rails_helper"

RSpec.describe "Merchant Items Show" do
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

  describe "US7 - show page" do
    describe "When I click the name of an item from the merchant I am taken to that merchants item's show page" do
      it "displays all the items attributes (name, description and current selling price)" do
        visit "/merchants/#{@merchant_1.id}/items"

        expect(page).to have_link(@item_1.name)
        expect(page).to have_link(@item_2.name)
        expect(page).to have_link(@item_3.name)
        expect(page).to have_link(@item_4.name)

        click_link(@item_1.name)


        within "#items-info" do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_1.description)
          expect(page).to have_content(@item_1.unit_price)
        end
      end
    end
  end
end
