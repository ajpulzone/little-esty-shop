class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      flash[:alert] = "Unable to complete your request, please fill out all fields"
      redirect_to new_merchant_bulk_discount_path(merchant.id)
    end
  end

private

  def bulk_discount_params
    params.permit(:discount_percent, :quantity_threshold)
  end

end 