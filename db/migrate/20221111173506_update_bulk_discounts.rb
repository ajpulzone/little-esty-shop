class UpdateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    change_column :bulk_discounts, :discount_percent, :integer
  end
end
