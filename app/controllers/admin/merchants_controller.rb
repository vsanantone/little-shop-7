class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end


  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:name])

    if  merchant.save
      redirect_to admin_merchant_path(merchant.id)
      flash[:success] = "Merchant info has been successfully updated."
    else 
      redirect_to edit_admin_merchant_path(merchant.id)
      flash[:error] = "Invalid data; name can't be blank." 
    end
  end

  def new  

  end

  def create
    merchant = Merchant.new({
      name: params[:name]
    })
    if merchant.save
      redirect_to "/admin/merchants"
    else
      flash[:alert] = "Please fill in the name field"
      render :new
    end
  end
end

