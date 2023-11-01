require 'rails_helper' 

RSpec.describe "Merchants Dashboard" do 
  before(:each) do 
    @merchant_1 = create(:merchant)
  end
  describe "visiting the merchant dashboard" do 
    it "displays the name of my merchant" do 
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end
    it "displays links to my merchant items index and my merchant invoices index." do 
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_link("My Items", :href => "/merchants/#{@merchant_1.id}/items")
      expect(page).to have_link("My Invoices", :href => "/merchants/#{@merchant_1.id}/invoices")
    end
  end
end 