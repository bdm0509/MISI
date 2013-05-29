class RemoveOrderStatusFkFromMaintenanceOrder < ActiveRecord::Migration
  def change
    remove_column :maintenance_orders, :order_status_type_id
  end
end
