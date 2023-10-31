require "rails_helper"

RSpec.describe Invoice, type: :model do
  before(:each) do

  end

  describe 'relationships' do
    it { should have_many :transactions }
    it { should belong_to :customer}
  end

  describe "validations" do
    
  end
end