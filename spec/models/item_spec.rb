require "rails_helper"

RSpec.describe Item, type: :model do
  before(:each) do
  end

  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe "methods" do
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
    describe "#best_day" do
      it "returns the day an item had its best sales" do
        expect(@item_2.best_day.created_at.strftime("%m/%d/%Y")).to eq("11/07/2023")
      end
    end
  end
end
