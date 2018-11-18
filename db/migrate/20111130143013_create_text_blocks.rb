class CreateTextBlocks < ActiveRecord::Migration
  def change
    create_table :text_blocks do |t|
      t.integer :id
      t.string :name
      t.text :text_block

      t.timestamps
    end
  end
end
