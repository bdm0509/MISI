class CreateAssureds < ActiveRecord::Migration
  def self.up
    create_table :assureds do |t|
      t.integer :id
      t.string :title
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :assureds
  end
end
