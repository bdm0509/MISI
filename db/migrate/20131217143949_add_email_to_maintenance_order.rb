class AddEmailToMaintenanceOrder < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :hoa_email, :string
  end
end
