require 'rails_helper' 

RSpec.describe "Merchants Dashboard" do 
  # before(:each) do 
  #   @merchant_1 = create(:merchant)
  # end
  describe "visiting the merchant dashboard" do 
    it "displays the name of my merchant" do 
      merchant_1 = create(:merchant)
      visit "/merchants/#{merchant_1.id}/dashboard"

      expect(page).to have_content(merchant_1.name)
    end
  end
end 