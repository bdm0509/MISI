class RemoveOrderStatusId < ActiveRecord::Migration[5.1]
  def change
    remove_column :maintenance_orders, :order_status_id
  end
end
