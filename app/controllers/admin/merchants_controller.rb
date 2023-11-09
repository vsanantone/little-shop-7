class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_five_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if params[:enabled]
      merchant.update(enabled: params[:enabled])
      redirect_back(fallback_location: "/admin/merchants")
    elsif params[:name]
      if merchant.update(name: params[:name])
        flash[:success] = "Merchant info has been successfully updated."
        redirect_to admin_merchant_path(merchant.id)
      else
        flash[:error] = "Invalid data; name can't be blank."
        redirect_to "/admin/merchants/#{merchant.id}/edit"
      end
    end
  end

  def new
  end

  def create
    merchant = Merchant.new({
      name: params[:name],
      enabled: false
    })

    if params[:name].blank?
      flash[:alert] = "Please fill in the name field"
      redirect_to "/admin/merchants/new"
    else
      merchant.save
      redirect_to "/admin/merchants"
    end
  end
end
