class AddArchivedToMaintenanceOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :maintenance_orders, :archived, :boolean, :default => false
  end
end
