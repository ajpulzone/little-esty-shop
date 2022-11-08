class Admin::InvoicesController < ApplicationController
  
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(invoice_params)
    @invoice.save
    redirect_to admin_invoice_path(@invoice.id)
  end

  def invoice_params
    params.permit(:customer_id, :status)
  end
  
end