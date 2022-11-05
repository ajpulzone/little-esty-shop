class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def item_name
    item.name
  end
end