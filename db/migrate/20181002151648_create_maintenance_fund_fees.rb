class CreateMaintenanceFundFees < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_fund_fees do |t|
      t.integer :maintenance_fund_id
      t.integer :year
      t.string  :amount
      t.string  :how_collected
      t.string  :other_fee_type
      t.integer :fee_collection_type_id

      t.timestamps
    end
  end
end
