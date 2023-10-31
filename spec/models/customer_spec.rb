require "rails_helper"

RSpec.describe Customer, type: :model do
  before(:each) do

  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe "validations" do
    
  end
end