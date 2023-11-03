require "rails_helper"

RSpec.describe "Admin Merchant Update" do
  it "updates the merchant through admin access" do
    merchant = create(:merchant)

    # 26. Admin Merchant Update
    # As an admin,
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    visit admin_merchant_path(merchant.id)
    # Then I see a link to update the merchant's information.
    expect(page).to have_link("Update Merchant Information")
    # When I click the link
    click_link("Update Merchant Information")
    
    # Then I am taken to a page to edit this merchant
    expect(current_path).to eq(edit_admin_merchant_path(merchant.id))
    # And I see a form filled in with the existing merchant attribute information
    expect(page).to have_field(:name, with: merchant.name)
    # When I update the information in the form and
    fill_in(:name, with: "John")
    # I click ‘submit’
    click_button("Submit")

    # Then I am redirected back to the merchant's admin show page where I see the updated information
    expect(current_path).to eq(admin_merchant_path(merchant.id))
    expect(page).to have_content("John")
    expect(page).to_not have_content(merchant.name)
    # And I see a flash message stating that the information has been successfully updated.
    save_and_open_page
    expect(page).to have_content("Merchant info has been successfully updated.")
  end
end
