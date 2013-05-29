class AddFieldsToMaintenanceFunds < ActiveRecord::Migration
  def up
    add_column :maintenance_funds, :amenities, :text
  end
  
  def down
    remove_column :maintenance_funds, :amenities, :text
  end
end
