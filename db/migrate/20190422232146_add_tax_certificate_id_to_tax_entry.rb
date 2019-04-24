class AddTaxCertificateIdToTaxEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :tax_entries, :tax_certificate_id, :integer
  end
end
