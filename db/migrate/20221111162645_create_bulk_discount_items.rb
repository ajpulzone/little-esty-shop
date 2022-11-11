class CreateBulkDiscountItems < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discount_items do |t|
      t.references :bulk_discount, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
