class ChangeFundFeeAmountToString < ActiveRecord::Migration
  def up
    change_table :maintenance_fund_fees do |t|
      t.change :amount, :string
    end
  end

  def down
    change_table :maintenance_fund_fees do |t|
      t.change :amount, :float
    end
  end
end
