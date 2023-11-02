class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_5_customers = @merchant.top_5_customers
  end
end