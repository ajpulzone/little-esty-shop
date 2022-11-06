class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five = Merchant.top_five(@merchant)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.new(item_params)

   if @item.save
    redirect_to merchant_items_path(params[:merchant_id])
   elsif
    render 'new'
   end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if params.has_key?('status')
      @item.update(status_params)
      redirect_to merchant_items_path
    elsif @item.update(item_params)
      redirect_to merchant_item_path(merchant_id: params[:merchant_id], id: params[:id])
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end

  def status_params
    params.permit(:status)
  end
end
