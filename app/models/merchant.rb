class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def unique_invoices
    invoices.distinct
  end

  def items_for_this_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end

  def invoice_revenue(invoice_id)
    items_for_this_invoice(invoice_id).sum('invoice_items.unit_price * invoice_items.quantity')
  end
end