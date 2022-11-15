class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :bulk_discounts, through: :items
  has_many :merchants, through: :items



  enum status: [ :completed, :cancelled, "in progress" ]

  def formatted_date
    created_at.strftime('%A, %B%e, %Y')
  end

  def numerical_date
    created_at.strftime('%-m/%-e/%y')
  end

  def self.incomplete_invoices
    self.joins(:invoice_items).where.not(invoice_items: {status: 2}).distinct.order(:created_at)
  end

  #this method was done in the group project and does not give the right answer
  def total_revenue
    items.sum("unit_price")
  end

  #this method is a new one I created for the solo project and does give the correct answer
  def total_invoice_revenue
    invoice_items.sum do |invoice_item|
    invoice_item.invoice_item_total_revenue
    end
  end 

  def total_invoice_discounts
    invoice_items.sum do |invoice_item|
      invoice_item.total_discount_amount
    end
  end

  def total_discounted_revenue
    total_invoice_revenue - total_invoice_discounts
  end
  
end