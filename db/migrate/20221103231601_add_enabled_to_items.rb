class AddEnabledToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :enabled, :integer
  end
end
