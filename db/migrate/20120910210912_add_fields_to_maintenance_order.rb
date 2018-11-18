class AddFieldsToMaintenanceOrder < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :fee, :string
    add_column :maintenance_orders, :year, :string
    add_column :maintenance_orders, :collector, :string
    add_column :maintenance_orders, :street, :string
    add_column :maintenance_orders, :city, :string
    add_column :maintenance_orders, :state, :string
    add_column :maintenance_orders, :zip, :string
    add_column :maintenance_orders, :phone, :string
  end
end
