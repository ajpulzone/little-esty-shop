class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.create(merchant_params)
    if @merchant.valid?
      redirect_to admin_merchants_path
    else
      flash[:errors] = @merchant.errors.full_messages
      render new
    end
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:status].present?
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif params.has_key?('merchant')
      @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant.id)
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
