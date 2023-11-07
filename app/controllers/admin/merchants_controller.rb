class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    #find our merchant
    @merchant = Merchant.find(params[:id])
    #use the request to update the merchant 
    @merchant.update(enabled: params[:enabled])
    #redirect to the admin merchants index
    redirect_to admin_merchants_path
  end
end
