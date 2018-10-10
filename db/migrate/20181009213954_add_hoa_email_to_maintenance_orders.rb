class AddHoaEmailToMaintenanceOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :maintenance_orders, :hoa_email, :string
  end
end
