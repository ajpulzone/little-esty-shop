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
    quantity * unit_price
  end

  def total_discount_amount
    if best_bulk_discount != nil
      (invoice_item_total_revenue * (best_bulk_discount.discount_percent.to_f/100)).round(0)
    else
      0
    end
  end

end


#best_bulk_discount in ruby

#   @qualifying_bulk_discounts = []
#   bulk_discounts.each do |discount|
#     if discount.quantity_threshold <= self.quantity
#       @qualifying_bulk_discounts << discount
#     end
#   end 
#   @qualifying_bulk_discounts.sort_by(&:discount_percent).last    
# end 

#attempts at US 6 finding the best bulk discount for an invoice item
 # @qualifying_bulk_discounts.sort_by({ |discount| discount.discount_percent })
 # @qualifying_bulk_discounts.sort_by({ |bulk_discount| bulk_discount.discount_percent })
#       item.merchant.bulk_discounts.where(self.quantity <= bulk_discounts.quantity_threshold)
#     @item_bulk_discounts =item.merchant.bulk_discounts.where(item.invoice_item.quantity <= item.merchant.bulk_discount.quantity_threshold).order(desc).first
#     item.merchant.bulk_discounts.select(bulk_discount.id).where(item.invoice_item.quantity <= item.merchant.bulk_discount.quantity)
#     # .joins(:bulk_discounts, [:blah, :blah2]).where('item.invoice_item.quantity >= bulk_discounts.quantity_threshold AND bulk_discount.merchant_id = item.merchant_id')

#     # .joins(items: [:invoice_items, :merchants]) #for direct relationships

#     # .joins(item: {merchant: :bulk_discounts}) #for nested relationships ()

#     # .joins(items: [:invoice_items, {merchant: :bulk_discounts}]) #can
#     item.bulk_discounts.where(self.quantity <= bulk_discounts.quantity_threshold).order(desc).first
#     item.bulk_discounts.pluck(:bulk_discounts).where(self.quantity <= bulk_discounts.quantity_threshold).order(desc).first
  
# bulk_discounts.select(:id, :discount_percent).where('self.quantity <= bulk_discounts.quantity_threshold').order(bulk_discounts.discount_percent, desc).first  
# bulk_discounts.select(:discount_percent).where('self.quantity <= bulk_discounts.quantity_threshold').order(:desc).first 
# bulk_discounts.select(:discount_percent).where('quantity <= bulk_discounts.quantity_threshold').order(:desc).first
#   end

# end