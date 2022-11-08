require 'json'

class MerchantsController < ApplicationController
  require 'net/https'
  def index
  end

  def show
    @merchant = Merchant.find(params[:id])
      uri = URI("https://api.github.com/users/freeing3092")
    @data = Net::HTTP.get(uri)
    @data = JSON.parse(@data)
  end
end
