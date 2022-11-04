class Merchant < ApplicationRecord
  has_many :items

  has_many :invoice_items, through: :items

  has_many :invoices, through: :items

  def unique_invoices
    invoices.distinct
  end

end