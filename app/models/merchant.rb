class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def unique_invoices
    invoices.distinct
  end
  
  def invoices_not_shipped
    invoice_items.where(status: ['0', '1'])
  end
  
  def merchant_top_5_customers
    # merch = Merchant.where(id: self.id)
    customers = Customer.select(:id, :first_name, :last_name, 'count(transactions.*) as number_transactions').joins(:transactions).joins(:merchants).where(['merchants.id = ? and transactions.result = ?', self.id, 'success']).group(:id).order('number_transactions desc').limit(5)
    # require "pry"; binding.pry
  end

end