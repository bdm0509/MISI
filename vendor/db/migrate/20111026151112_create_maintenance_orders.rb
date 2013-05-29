class CreateMaintenanceOrders < ActiveRecord::Migration
  def up
    create_table :maintenance_orders do |t|
      t.integer :id
      t.integer :assured_id
      t.date :order_date
      t.date :report_date
      t.text :legal_description
      t.string :buyer
      t.string :seller
      t.text :property_address
      t.date :date_checked
      t.integer :maintenance_fund_id
      t.integer :order_status_id
      t.text :special_instructions
      t.text :amenities

      t.timestamps
    end
  end
  
  def down
    drop_table :maintenance_orders
  end
end
