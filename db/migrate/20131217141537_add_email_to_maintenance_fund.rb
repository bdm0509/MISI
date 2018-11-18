class AddEmailToMaintenanceFund < ActiveRecord::Migration
  def change
    add_column :maintenance_funds, :email, :string
  end
end
