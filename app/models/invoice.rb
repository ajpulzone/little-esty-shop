class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def formatted_date
    created_at.strftime('%A, %B%e, %Y')
  end
  
end