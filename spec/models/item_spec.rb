require "rails_helper"

RSpec.describe Item, type: :model do
  before(:each) do

  end

  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items)}
    it { should belong_to :merchant}
  end

  describe "validations" do
    
  end
end