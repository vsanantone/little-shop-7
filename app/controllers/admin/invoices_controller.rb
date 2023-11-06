class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to "/admin/invoices/#{@invoice.id}"
    end
  end

  private

  def invoice_params
    params.permit(:status)
  end
end

