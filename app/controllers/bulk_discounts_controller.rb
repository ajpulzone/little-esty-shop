class BulkDiscountsController < ApplicationController

  before_action :get_holiday_info, only: :index

  def get_holiday_info
    @holidays = HolidaySearch.new.holiday_information.take(3)
  end

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

  def destroy
    @bulk_discount = BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(@bulk_discount.merchant)
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(bulk_discount_params)
      redirect_to bulk_discount_path(@bulk_discount.id)
    else 
    flash[:alert] = "Unable to complete your request, please ensure all fields are filled out"
      redirect_to edit_bulk_discount_path(@bulk_discount.id)
    end
  end

private

  def bulk_discount_params
    params.permit(:discount_percent, :quantity_threshold)
  end

end 