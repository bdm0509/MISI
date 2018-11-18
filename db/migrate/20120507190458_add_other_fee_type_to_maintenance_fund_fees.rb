class AddOtherFeeTypeToMaintenanceFundFees < ActiveRecord::Migration
  def change
    add_column :maintenance_fund_fees, :other_fee_type, :string
  end
end
