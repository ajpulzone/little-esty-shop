class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [ :pending, :packaged, :shipped ]

  def item_name
    item.name
  end

  def invoice_item_discount
    
  end
end