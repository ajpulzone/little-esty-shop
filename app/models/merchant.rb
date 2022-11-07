class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def unique_invoices
    invoices.distinct
  end

  def items_for_this_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end

  def invoice_revenue(invoice_id)
    items_for_this_invoice(invoice_id).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def invoices_not_shipped
    invoice_items.where(status: ['0', '1'])
  end

  def self.top_five(merchant)
    find_by_sql(["select merchants.name, invoices.id as invoice_id, result as result_of_transaction, invoice_items.quantity*invoice_items.unit_price as revenue, invoice_items.quantity, invoice_items.unit_price, items.name as item from merchants join items on merchants.id = items.merchant_id join invoice_items on invoice_items.item_id = items.id join invoices on invoice_items.id = invoices.id join transactions on transactions.invoice_id = invoices.id where result = 'success' and  merchants.id = ? order by revenue desc limit 5", merchant.id])
  end

end
