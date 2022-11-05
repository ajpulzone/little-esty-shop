class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items

  validates_presence_of :name

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def unique_invoices
    invoices.distinct
  end
  
  def invoices_not_shipped
    invoice_items.where(status: ['0', '1'])
  end
end