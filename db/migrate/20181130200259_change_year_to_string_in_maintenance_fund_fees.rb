class ChangeYearToStringInMaintenanceFundFees < ActiveRecord::Migration[5.1]
  def change
    change_column :maintenance_fund_fees, :year, :string
  end
end
