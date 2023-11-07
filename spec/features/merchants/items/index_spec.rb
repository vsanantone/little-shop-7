require "rails_helper"

RSpec.describe "Merchant Items Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id, status: 1)
    @item_2 = create(:item, merchant_id: @merchant_1.id, status: 1)
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

  describe "US9 - Item Disable/Enable" do
    describe "visit the merchants items index I see a button next to each item to disable or enable that item" do
      describe "when I click the button I am redirected back to the items index" do
        it "I see that the items status has changed" do
          visit "/merchants/#{@merchant_1.id}/items"

          within "#merchants-items" do
            expect(page).to have_content("Item's Status: enabled")
            expect(page).to have_button("Disable #{@item_1.name}")

            expect(page).to have_content("Item's Status: #{@item_2.status}")
            expect(page).to have_button("Disable #{@item_2.name}")

            expect(page).to have_content("Item's Status: #{@item_3.status}")
            expect(page).to have_button("Enable #{@item_3.name}")

            expect(page).to have_content("Item's Status: #{@item_4.status}")
            expect(page).to have_button("Enable #{@item_4.name}")
          end

          click_button("Disable #{@item_1.name}")

          expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

          within "#merchants-items" do
            expect(page).to have_content("Item's Status: disabled")
            expect(page).to have_button("Enable #{@item_1.name}")

            expect(page).to have_content("Item's Status: #{@item_2.status}")
            expect(page).to have_button("Disable #{@item_2.name}")

            expect(page).to have_content("Item's Status: #{@item_3.status}")
            expect(page).to have_button("Enable #{@item_3.name}")

            expect(page).to have_content("Item's Status: #{@item_4.status}")
            expect(page).to have_button("Enable #{@item_4.name}")
          end
        end
      end
    end
  end

  describe "US 10 - items grouped  by status" do
    describe "visit the merchants items index page I see two sections one for enabled items and one for disabled items" do
      it "I see that each item is listed in the appropriate section" do
        visit "/merchants/#{@merchant_1.id}/items"

        within "#enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_link(@item_3.name)
          expect(page).to have_link(@item_4.name)
        end

        within "#disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link(@item_1.name)
          expect(page).to have_link(@item_2.name)
        end
      end
    end
  end
end
