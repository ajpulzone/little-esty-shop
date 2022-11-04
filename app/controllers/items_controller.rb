class ItemsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    if params.has_key? 'merchant_id'
      @merchant = Merchant.find(params[:merchant_id])
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    require 'pry'; binding.pry
    @item = Item.find(params[:id])


    if @item.update(item_params)
    redirect_to merchant_item_path(merchant_id: params[:merchant_id], id: params[:id])
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :enabled)
  end
end
