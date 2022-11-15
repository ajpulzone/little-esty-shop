class BulkDiscount < ApplicationRecord

  belongs_to :merchant
  has_many :bulk_discount_items
  has_many :items, through: :bulk_discount_items
  has_many :invoice_items, through: :items

  validates_presence_of :discount_percent
  validates_presence_of :quantity_threshold
end