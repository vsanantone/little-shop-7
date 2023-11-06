class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.group(:id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_back(fallback_location: "/")
  end

  private
  def item_params
    params.permit(:status)
  end
end
