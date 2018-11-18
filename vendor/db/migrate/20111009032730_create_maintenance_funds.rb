class CreateMaintenanceFunds < ActiveRecord::Migration
  def self.up
    create_table :maintenance_funds do |t|
      t.integer :id
      t.string :name
      t.string :collector
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact
      t.text   :instructions

      t.timestamps
    end
  end

  def self.down
    drop_table :maintenance_funds
  end
end
