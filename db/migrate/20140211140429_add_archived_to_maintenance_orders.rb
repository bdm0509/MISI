class AddArchivedToMaintenanceOrders < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :archived, :boolean, default: false
  end
end
