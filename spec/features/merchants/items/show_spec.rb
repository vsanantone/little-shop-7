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

  describe "US 8 - update" do
    describe "On the merchant's item show page I see a link to update the item information" do
      describe "the link takes me to a page to edit the item, the form is filled in with existing item attribute info" do
        describe "when I update the information in the form and click submit, I am redirected back to the item show page" do
          it "I see the updated info and a flash message stating that the info has been successfully updated" do
            visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

            expect(page).to have_link("Update Item Information")

            click_link("Update Item Information")

            expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")

            expect(page).to have_content("Name:")
            expect(page).to have_content("Description:")
            expect(page).to have_content("Unit Price:")

            fill_in("Name:", with: "Sakuna's Finger")
            fill_in("Description:", with: "One of twenty cursed objects that come from a demon")
            fill_in("Unit Price:", with: 6666)

            click_button("Update Item Info")

            expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

            expect(page).to have_content("Sakuna's Finger")
            expect(page).to have_content("One of twenty cursed objects that come from a demon")
            expect(page).to have_content("$66.66")
          end
        end
      end
    end
  end
end
