class AddFaxToMaintenanceOrder < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :hoa_fax, :string
  end
end
