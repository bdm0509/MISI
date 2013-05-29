class ChangeOrderStatusTypeInMaintenanceOrders < ActiveRecord::Migration
  def up
    rename_column :maintenance_orders, :order_status_id, :order_status_type_id
  end

  def down
    rename_column :maintenance_orders, :order_status_type_id, :order_status_id
  end
end
