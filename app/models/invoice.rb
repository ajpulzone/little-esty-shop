class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: {
    completed: 0,
    cancelled: 1, 
    "in progress": 2
    }

  def formatted_date
    created_at.strftime('%A, %B%e, %Y')
  end

  def self.incomplete_invoices
    self.joins(:invoice_items).where.not(invoice_items: {status: 2}).distinct.order(:created_at)
  end

  def total_revenue
    items.sum("unit_price")
  end

end