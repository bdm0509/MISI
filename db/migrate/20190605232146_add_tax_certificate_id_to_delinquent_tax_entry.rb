class AddTaxCertificateIdToDelinquentTaxEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :delinquent_tax_entries, :tax_certificate_id, :integer
  end
end
