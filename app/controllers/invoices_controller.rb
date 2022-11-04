class InvoicesController < ApplicationController
  def index
<<<<<<< HEAD
    
  end
=======
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
  
>>>>>>> 0f88ddc2fa8600a78ed686e96cb6da777b353e40
end