class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def unique_invoices
    invoices.distinct
  end
  
  def invoices_not_shipped
    invoice_items.where(status: ['0', '1'])
  end
  
  def merchant_top_5_customers
    customers.select(:id, :first_name, :last_name, 'count(transactions.*) as number_transactions').joins(:transactions).where('transactions.result =?','success').group(:id).order('number_transactions desc').limit(5)
  end

end