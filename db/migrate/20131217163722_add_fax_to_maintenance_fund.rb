class AddFaxToMaintenanceFund < ActiveRecord::Migration
  def change
    add_column :maintenance_funds, :fax, :string
  end
end
