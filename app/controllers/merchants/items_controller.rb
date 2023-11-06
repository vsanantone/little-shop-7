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

    # if params[:update_item]
    #   @item.update(item_params)
    #   @item.save

    #   flash[:success] = "Item information updated successfully."
    #   redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    # else
    #   flash[:error] = "Item information not updated properly, try again."
    #   redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    # end

    # require "pry"
    # binding.pry

    if params[:status] == "enable"
      @item.update(status: :enabled)
      redirect_to "/merchants/#{@merchant.id}/items"

    elsif params[:status] == "disable"
      @item.update(status: :disabled)
      redirect_to "/merchants/#{@merchant.id}/items"

    elsif @item.update(item_params)
      @item.save

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
