class AddOrderStatusToMaintenanceOrder < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :order_status, :string
  end
end
