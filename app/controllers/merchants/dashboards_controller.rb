class Merchants::DashboardsController < ApplicationController

  def show
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @top_5_customers = @merchant.top_5_customers
    @items_ready_to_ship = @merchant.shippable_items
  end
end