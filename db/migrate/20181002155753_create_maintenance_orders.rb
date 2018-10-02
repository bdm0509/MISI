class CreateMaintenanceOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_orders do |t|
      t.integer :assured_id
      t.date    :order_date
      t.date    :report_date
      t.text    :legal_description
      t.string  :buyer
      t.string  :seller
      t.text    :property_address
      t.date    :date_checked
      t.integer :maintenance_fund_id
      t.integer :order_status_id
      t.text    :special_instructions
      t.text    :amenities
      t.text    :delinquent
      t.string  :gf
      
      t.string  :hoa_fee
      t.string  :hoa_fee_year
      t.string  :hoa_collector
      t.string  :hoa_street
      t.string  :hoa_city
      t.string  :hoa_state
      t.string  :hoa_zip
      t.string  :hoa_phone
      
      t.string  :order_status
      
      t.timestamps
    end
  end
end
