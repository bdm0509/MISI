class AddBackFeeTypes < ActiveRecord::Migration
  def up
    create_table :fee_collection_types do |t|
      t.integer :id
      t.string :type_string
      t.string :description

      t.timestamps
    end
  end
  
  def self.down
    drop_table :fee_collection_types
  end
end