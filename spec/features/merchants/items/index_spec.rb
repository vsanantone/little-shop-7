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
    @item_5 = create(:item, merchant_id: @merchant_2.id, status: 0)
    @item_6 = create(:item, merchant_id: @merchant_2.id, status: 1)
    @item_7 = create(:item, merchant_id: @merchant_3.id, status: 1)
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
        it "I see that the items status has been disabled" do
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

        it "I see that the items status has been enabled" do
          visit "/merchants/#{@merchant_1.id}/items"

          within "#merchants-items" do
            expect(page).to have_content("Item's Status: #{@item_1.status}")
            expect(page).to have_button("Disable #{@item_1.name}")

            expect(page).to have_content("Item's Status: #{@item_2.status}")
            expect(page).to have_button("Disable #{@item_2.name}")

            expect(page).to have_content("Item's Status: #{@item_3.status}")
            expect(page).to have_button("Enable #{@item_3.name}")

            expect(page).to have_content("Item's Status: #{@item_4.status}")
            expect(page).to have_button("Enable #{@item_4.name}")
          end

          click_button("Enable #{@item_3.name}")

          expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

          within "#merchants-items" do
            expect(page).to have_content("Item's Status: disabled")
            expect(page).to have_button("Disable #{@item_1.name}")

            expect(page).to have_content("Item's Status: #{@item_2.status}")
            expect(page).to have_button("Disable #{@item_2.name}")

            expect(page).to have_content("Item's Status: #{@item_3.status}")
            expect(page).to have_button("Disable #{@item_3.name}")

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
          expect(page).to have_link(@item_1.name)
          expect(page).to have_link(@item_2.name)
        end

        within "#disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link(@item_3.name)
          expect(page).to have_link(@item_4.name)
        end
      end
    end
  end

  describe "US 11 - create an item" do
    describe "I see a link to create a new item, I click the link, am taken to a form that allows me to add item info" do
      it "I click submit, and am taken back to the index page and see the item listed with a default status of disabled" do
        visit "/merchants/#{@merchant_1.id}/items"

        expect(page).to have_link("Create New Item")
        click_link("Create New Item")

        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/new")
        expect(page).to have_content("Name:")
        expect(page).to have_content("Description:")
        expect(page).to have_content("Unit Price:")

        fill_in("Name:", with: "Black Nichirin Sword")
        fill_in("Description:", with: "Mysterious, considered a bad omen that the wielder will die young")
        fill_in("Unit Price:", with: 9999)
        click_button("Submit")

        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

        within "#disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link("Black Nichirin Sword")
          expect(page).to have_button("Enable Black Nichirin Sword")
        end
      end
    end
  end

  describe "US 12 and 13 data" do
    before(:each) do
      @item_5 = create(:item, merchant: @merchant_1)
      @item_6 = create(:item, merchant: @merchant_1)
      @item_7 = create(:item, merchant: @merchant_1)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "2023-11-07 07:07:07 UTC")
      @invoice_2 = create(:invoice, customer: @customer_1, created_at: "2023-11-07 07:07:07 UTC")
      @invoice_3 = create(:invoice, customer: @customer_2, created_at: "2021-07-11 11:11:11 UTC")
      @invoice_4 = create(:invoice, customer: @customer_2, created_at: "2021-07-11 11:11:11 UTC")

      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 500, status: 1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1, quantity: 1, unit_price: 1000, status: 1)
      @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 3, unit_price: 1000, status: 1)
      @invoice_item_4 = create(:invoice_item, item: @item_3, invoice: @invoice_2, quantity: 2, unit_price: 1500, status: 1)
      @invoice_item_5 = create(:invoice_item, item: @item_4, invoice: @invoice_2, quantity: 10, unit_price: 40, status: 1)
      @invoice_item_6 = create(:invoice_item, item: @item_5, invoice: @invoice_1, quantity: 1, unit_price: 1000, status: 1)
      @invoice_item_7 = create(:invoice_item, item: @item_6, invoice: @invoice_1, quantity: 7, unit_price: 500, status: 1)
      @invoice_item_8 = create(:invoice_item, item: @item_7, invoice: @invoice_1, quantity: 4, unit_price: 1200, status: 1)
      @invoice_item_9 = create(:invoice_item, item: @item_7, invoice: @invoice_3, quantity: 10, unit_price: 1200, status: 1)
      @invoice_item_10 = create(:invoice_item, item: @item_7, invoice: @invoice_4, quantity: 7, unit_price: 1000, status: 1)
    end
    describe "US 12 - Most Popular Items" do
      describe "I see the names of the top 5 most popular items by total revenue generate" do
        describe "each item links to its show page" do
          it "total revenue generated is also next to each item" do
            visit "/merchants/#{@merchant_1.id}/items"

            expect(page).to have_content("Top 5 Most Popular Items")

            within("#popular-items") do
              expect(page).to have_link(@item_2.name)
              expect(page).to have_link(@item_3.name)
              expect(page).to have_link(@item_5.name)
              expect(page).to have_link(@item_6.name)
              expect(page).to have_link(@item_7.name)

              expect(@item_7.name).to appear_before(@item_2.name)
              expect(@item_2.name).to appear_before(@item_6.name)
              expect(@item_6.name).to appear_before(@item_3.name)
              expect(@item_3.name).to appear_before(@item_5.name)

              expect(page).to have_content("#{@item_7.name} Total revenue: $238.00")
              expect(page).to have_content("#{@item_2.name} Total revenue: $40.00")
              expect(page).to have_content("#{@item_6.name} Total revenue: $35.00")
              expect(page).to have_content("#{@item_3.name} Total revenue: $30.00")
              expect(page).to have_content("#{@item_5.name} Total revenue: $10.00")
            end
          end
        end
      end
    end

    describe "US 13 - Top Items Best Day" do
      describe "next to each of the 5 most popular items I see the date with the most sales for each item" do
        it "I see a label “Top selling date for <item name> was <date with most sales>" do
          visit "/merchants/#{@merchant_1.id}/items"

          expect(page).to have_content("Top selling date for #{@item_7.name} was 07/11/2021")
          expect(page).to have_content("Top selling date for #{@item_2.name} was 11/07/2023")
          expect(page).to have_content("Top selling date for #{@item_6.name} was 11/07/2023")
          expect(page).to have_content("Top selling date for #{@item_3.name} was 11/07/2023")
          expect(page).to have_content("Top selling date for #{@item_5.name} was 11/07/2023")
        end
      end
    end
  end
end
