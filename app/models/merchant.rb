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
    invoice_items.select('invoice_items.*').joins(:item).joins(:invoice).where(status: ['0', '1']).order('invoices.created_at')
  end
  
  def merchant_top_5_customers
    Customer.select(:id, :first_name, :last_name, 'count(transactions.*) as number_transactions').joins(invoices: [:items, :transactions]).where(['items.merchant_id = ? and transactions.result = ?', self.id, 'success']).group(:id).order('number_transactions desc').limit(5)
  end

end