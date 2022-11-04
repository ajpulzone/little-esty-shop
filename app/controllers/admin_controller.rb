class AdminController < ApplicationController

  def index
    @customers = Customer.all
    @invoices = Invoice.all
    binding.pry
  end
end