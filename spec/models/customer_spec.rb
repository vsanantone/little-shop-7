require "rails_helper"

RSpec.describe Customer, type: :model do
  before(:each) do
    @customer1 = Customer.create!(first_name: "John", last_name: "Doe")
    @invoice1 = Invoice.create!(status: 1, customer_id: "#{@customer1.id}")
    @transaction1 = Transaction.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction2 = Transaction.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction3 = Transaction.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")
    @transaction4 = Transaction.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1, invoice_id: "#{@invoice1.id}")

    @customer2 = Customer.create!(first_name: "Mary", last_name: "Jane")
    @invoice2 = @customer2.invoices.create!(status: 1)
    @transaction5 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction6 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction7 = @invoice2.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer3 = Customer.create!(first_name: "Johnny", last_name: "Bowflex")
    @invoice3 = @customer3.invoices.create!(status:1)
    @transaction8 = @invoice3.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction9 = @invoice3.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction10 = @invoice3.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction11 = @invoice3.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction12 = @invoice3.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer4 = Customer.create!(first_name: "Alvin", last_name: "Setter")
    @invoice4 = @customer4.invoices.create!(status:1)
    @transaction13 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction14 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction15 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction16 = @invoice4.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)

    @customer5 = Customer.create!(first_name: "Masison", last_name: "House")
    @invoice5 = @customer5.invoices.create!(status: 1)
    @transaction17 = @invoice5.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
    @transaction18 = @invoice5.transactions.create!(credit_card_number: "1234567890", credit_card_expiration_date: "4/27", result: 1)
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  it "self.top_five_customers" do
    expect(Customer.top_five_customers.first.first_name).to eq(@customer3.first_name)
    expect(Customer.top_five_customers[1].first_name).to eq(@customer1.first_name)
    expect(Customer.top_five_customers[2].first_name).to eq(@customer4.first_name)
    expect(Customer.top_five_customers[3].first_name).to eq(@customer2.first_name)
    expect(Customer.top_five_customers.last.first_name).to eq(@customer5.first_name)
  end
end