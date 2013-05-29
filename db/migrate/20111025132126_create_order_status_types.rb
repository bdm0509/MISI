class CreateOrderStatusTypes < ActiveRecord::Migration
  def up
    create_table :order_status_types do |t|
      t.integer :id
      t.string :type_string
      t.string :description

      t.timestamps
    end
  end
  
  def down
    drop_table :order_status_types
  end
end
