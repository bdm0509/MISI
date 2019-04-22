class CreateTaxStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_statuses do |t|
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
