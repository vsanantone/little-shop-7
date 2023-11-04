class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @my_items = @invoice.merchant_items(params[:merchant_id])
  end
end