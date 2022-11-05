class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def unique_invoices
    invoices.distinct
  end

  def invoice_items_for_this_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end

end