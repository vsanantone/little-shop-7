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
    @item = Item.find(params[:item_id])
    if params[:item_update] == "Update_item"
      @item.update(item_params)
      flash[:success] = "Item information updated successfully."
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    end
    if params[:status] == "Enable"
      @item.update(status: enable)
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif params[:status] == "Disable"
      @item.update(status: disable)
      redirect_to "/merchants/#{@merchant.id}/items"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
