class CreateMaintenanceFunds < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_funds do |t|
      t.string :name
      t.string :collector
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact
      t.text   :instructions
      t.text   :amenities

      t.timestamps
    end
  end
end
