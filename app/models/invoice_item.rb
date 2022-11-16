class InvoiceItem < ApplicationRecord

  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :item

  enum status: [ :pending, :packaged, :shipped ]

  def item_name
    item.name
  end

  def best_bulk_discount
    bulk_discounts.where('quantity_threshold <= ?', quantity).order(discount_percent: :desc).first
  end

  def invoice_item_total_revenue
    quantity * unit_price.to_f
  end

  def total_discount_amount
    if best_bulk_discount != nil
      (invoice_item_total_revenue * (best_bulk_discount.discount_percent.to_f/100)).round(0)
    else
      0
    end
  end

end