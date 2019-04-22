class CreateTaxEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_entries do |t|
      t.integer :collection_district_id
      t.integer :district_type_id
      t.string :account_number
      t.string :year
      t.string :base_tax
      t.integer :tax_status_id

      t.timestamps
    end
  end
end
