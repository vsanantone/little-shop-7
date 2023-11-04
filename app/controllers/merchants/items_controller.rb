class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.group(:id)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_params)

    if @item.save
      flash[:success] = "Item information updated successfully."
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    else
      flash[:error] = "Item information not updated properly, try again."
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
