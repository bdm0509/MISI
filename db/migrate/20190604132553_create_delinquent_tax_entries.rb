class CreateDelinquentTaxEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :delinquent_tax_entries do |t|
      t.integer :collection_district_id
      t.string :account_number
      t.string :year_due
      t.string :amount

      t.timestamps
    end
  end
end
