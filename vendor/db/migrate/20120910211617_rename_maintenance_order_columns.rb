class RenameMaintenanceOrderColumns < ActiveRecord::Migration
  def change
    rename_column :maintenance_orders, :fee, :hoa_fee
    rename_column :maintenance_orders, :year, :hoa_fee_year
    rename_column :maintenance_orders, :collector, :hoa_collector
    rename_column :maintenance_orders, :street, :hoa_street
    rename_column :maintenance_orders, :city, :hoa_city
    rename_column :maintenance_orders, :state, :hoa_state
    rename_column :maintenance_orders, :zip, :hoa_zip
    rename_column :maintenance_orders, :phone, :hoa_phone
  end
end
