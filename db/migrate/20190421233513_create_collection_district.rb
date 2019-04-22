class CreateCollectionDistrict < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_districts do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
