require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    @invoice1 = @customer1.invoices.create!(status: 1)
    @transaction1 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction2 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction3 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction4 = @invoice1.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")

    @customer2 = Customer.create!(first_name: "Mary", last_name: "Jane")
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer2.invoices.create!(status: 2)
    @transaction5 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction6 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction7 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer3 = Customer.create!(first_name: "Johnny", last_name: "Bowflex")
    @invoice4 = @customer3.invoices.create!(status:1)
    @invoice5 = @customer3.invoices.create!(status:0)
    @invoice6 = @customer3.invoices.create!(status:0)
    @invoice7 = @customer3.invoices.create!(status:2)
    @transaction8 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction9 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction10 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction11 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction12 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer4 = Customer.create!(first_name: "Alvin", last_name: "Setter")
    @invoice8 = @customer4.invoices.create!(status:1)
    @invoice9 = @customer4.invoices.create!(status:0)
    @invoice10 = @customer4.invoices.create!(status:2)
    @transaction13 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction14 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction15 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction16 = @invoice8.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer5 = Customer.create!(first_name: "Masison", last_name: "House")
    @invoice11 = @customer5.invoices.create!(status: 1)
    @invoice12 = @customer5.invoices.create!(status: 2)
    @invoice13 = @customer5.invoices.create!(status: 2)
    @invoice14 = @customer5.invoices.create!(status: 0)
    @transaction17 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0)
    @transaction18 = @invoice11.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 0)

    @item1 = create(:item)
    @item2 = create(:item)
    @item3 = create(:item)
    @item4 = create(:item)
    @item5 = create(:item)
    @item6 = create(:item)
    @item7 = create(:item)
    @item8 = create(:item)
    # @item9 = create(:item)

    @invoice_item_1 = create(:invoice_item, status: 0, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item_2 = create(:invoice_item, status: 0, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item_3 = create(:invoice_item, status: 0, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item_4 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item4.id)
    @invoice_item_5 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item5.id)
    @invoice_item_6 = create(:invoice_item, status: 0, invoice_id: @invoice4.id, item_id: @item6.id)
    @invoice_item_7 = create(:invoice_item, status: 0, invoice_id: @invoice8.id, item_id: @item7.id)
    @invoice_item_8 = create(:invoice_item, status: 0, invoice_id: @invoice11.id, item_id: @item8.id)

    @invoice_item_test_1 = create(:invoice_item, status: 0, unit_price: 13635, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item_test_2 = create(:invoice_item, status: 0, unit_price: 10000, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item_test_3 = create(:invoice_item, status: 0, unit_price: 2195, invoice_id: @invoice1.id, item_id: @item1.id)
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "validations" do
    it { should validate_presence_of(:status) } 
    it { should validate_presence_of(:quantity) } 
    it { should validate_presence_of(:unit_price) } 
  end

  it "unit_price_show" do
    expect(@invoice_item_test_1.unit_price_show).to eq(136.35)
    expect(@invoice_item_test_2.unit_price_show).to eq((@invoice_item_test_2.unit_price.to_f / 100).round(2))
    expect(@invoice_item_test_3.unit_price_show).to eq((@invoice_item_test_3.unit_price.to_f / 100).round(2))
    expect(@invoice_item_test_3.unit_price_show).to eq(21.95)
  end
end