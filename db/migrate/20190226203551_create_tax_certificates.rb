class CreateTaxCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_certificates do |t|
      t.string :gf
      t.string :title_company
      t.string :certificate
      t.integer :order
      t.string :buyer
      t.text :property_address

      t.timestamps
    end
  end
end
