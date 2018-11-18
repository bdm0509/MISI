class AddDelinquentToMaintenanceOrder < ActiveRecord::Migration
  def change
    add_column :maintenance_orders, :delinquent, :text
  end
end
