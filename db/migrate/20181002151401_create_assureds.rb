class CreateAssureds < ActiveRecord::Migration[5.1]
  def change
    create_table :assureds do |t|
      t.string :title
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact
      t.float  :fee

      t.timestamps
    end
  end
end
