class AddGfToMaintenanceOrder < ActiveRecord::Migration
  def up
    add_column :maintenance_orders, :gf, :string
  end
  
  def down
    remove_column :maintenance_orders, :gf, :string
  end
end
