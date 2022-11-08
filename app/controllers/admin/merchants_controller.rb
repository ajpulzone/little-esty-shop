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
    @merchant = Merchant.find(params[:id])
    if params[:status].present?
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif params.has_key?('merchant')
      @merchant.update(update_params)
      redirect_to admin_merchant_path(@merchant.id)
    end
  end

  private

  def update_params
    params.require(:merchant).permit(:name)
  end
end
