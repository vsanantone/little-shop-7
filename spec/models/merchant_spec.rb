require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do 
    @merchant_1 = create(:merchant)

    item = create(:item, merchant_id: @merchant_1.id)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    c1_invoice_1 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_2 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c1_invoice_3 = create(:invoice, status: 1, customer_id: @customer_1.id)
    c2_invoice_1 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_2 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_3 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c2_invoice_4 = create(:invoice, status: 1, customer_id: @customer_2.id)
    c3_invoice_1 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_2 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c3_invoice_3 = create(:invoice, status: 1, customer_id: @customer_3.id)
    c4_invoice_1 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c4_invoice_2 = create(:invoice, status: 1, customer_id: @customer_4.id)
    c5_invoice_1 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_2 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_3 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_4 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c5_invoice_5 = create(:invoice, status: 1, customer_id: @customer_5.id)
    c6_invoice_1 = create(:invoice, status: 1, customer_id: @customer_6.id)

    c1_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c1_invoice_1.id, item_id: item.id)
    c1_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c1_invoice_2.id, item_id: item.id)
    c1_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c1_invoice_3.id, item_id: item.id)

    c2_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c2_invoice_1.id, item_id: item.id)
    c2_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c2_invoice_2.id, item_id: item.id)
    c2_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c2_invoice_3.id, item_id: item.id)
    c2_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c2_invoice_4.id, item_id: item.id)

    c3_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c3_invoice_1.id, item_id: item.id)
    c3_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c3_invoice_2.id, item_id: item.id)
    c3_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c3_invoice_3.id, item_id: item.id)

    c4_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c4_invoice_1.id, item_id: item.id)
    c4_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c4_invoice_2.id, item_id: item.id)

    c5_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c5_invoice_1.id, item_id: item.id)
    c5_invoice_item_2 = create(:invoice_item, status: 2, invoice_id: c5_invoice_2.id, item_id: item.id)
    c5_invoice_item_3 = create(:invoice_item, status: 2, invoice_id: c5_invoice_3.id, item_id: item.id)
    c5_invoice_item_4 = create(:invoice_item, status: 2, invoice_id: c5_invoice_4.id, item_id: item.id)
    c5_invoice_item_5 = create(:invoice_item, status: 2, invoice_id: c5_invoice_5.id, item_id: item.id)

    c6_invoice_item_1 = create(:invoice_item, status: 2, invoice_id: c6_invoice_1.id, item_id: item.id)
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "#top_5_customers" do 
    it "finds the top 5 customers associated with a merchant based on succesful transactions" do 
      top_5 = @merchant_1.top_5_customers
      expect(top_5.first.first_name).to eq(@customer_5.first_name)
    end
  end
end