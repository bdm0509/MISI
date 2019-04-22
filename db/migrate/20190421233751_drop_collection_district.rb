class DropCollectionDistrict < ActiveRecord::Migration[5.1]
  def change
    drop_table :collection_districts
  end
end
