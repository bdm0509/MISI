class AddEmailToMaintenanceFunds < ActiveRecord::Migration[5.1]
  def change
    add_column :maintenance_funds, :email, :string
  end
end
