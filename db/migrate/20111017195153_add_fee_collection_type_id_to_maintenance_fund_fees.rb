class AddFeeCollectionTypeIdToMaintenanceFundFees < ActiveRecord::Migration
  def up
    add_column :maintenance_fund_fees, :fee_collection_type_id, :integer
  end
  
  def down
    remove_column :maintenance_fund_fees, :fee_collection_type_id, :integer
  end
end
