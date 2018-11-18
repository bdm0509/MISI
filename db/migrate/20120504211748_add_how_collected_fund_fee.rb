class AddHowCollectedFundFee < ActiveRecord::Migration
  def up
    add_column :maintenance_fund_fees, :how_collected, :string
  end

  def down
    remove_column :maintenance_fund_fees, :how_collected, :string
  end
end
