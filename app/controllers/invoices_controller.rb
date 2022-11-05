class InvoicesController < ApplicationController
  def index
    if params[:merchant_id].present?
      @merchant = Merchant.find(params[:merchant_id])
    elsif params[:id].present?
      @merchant = Merchant.find(params[:id])
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end
end