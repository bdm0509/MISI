class AddFaxToMaintenanceFunds < ActiveRecord::Migration[5.1]
  def change
    add_column :maintenance_funds, :fax, :string
  end
end
