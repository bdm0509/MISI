class CreateTextBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :text_blocks do |t|
      t.string :name
      t.text :text_block

      t.timestamps
    end
  end
end
