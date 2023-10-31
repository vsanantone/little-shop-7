require "rails_helper"

RSpec.describe Invoice, type: :model do
  before(:each) do

  end

  describe 'relationships' do
    it { should have_many :transactions }
    it { should belong_to :customer}
  end

  describe "validations" do
    it { should validate_presence_of(:status) } 
  end
end