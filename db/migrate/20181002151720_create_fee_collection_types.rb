class CreateFeeCollectionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :fee_collection_types do |t|
      t.string :type_string
      t.string :description

      t.timestamps
    end
  end
end
