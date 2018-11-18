class DropFundTypeTable < ActiveRecord::Migration
  def up
    drop_table :fee_collection_types
  end

  def down
  end
end
