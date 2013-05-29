class CreateMaintenanceFundFees < ActiveRecord::Migration
  def up
    create_table :maintenance_fund_fees do |t|
      t.integer :id
      t.integer :maintenance_fund_id
      t.integer :year
      t.float :amount

      t.timestamps
    end
    
    #add_index :maintenance_fund_fees, :maintenance_fund_id
  end
  
  def self.down
    drop_table :maintenance_fund_fees
  end
end
