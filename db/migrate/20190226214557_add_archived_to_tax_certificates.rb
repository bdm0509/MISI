class AddArchivedToTaxCertificates < ActiveRecord::Migration[5.1]
  def change
    add_column :tax_certificates, :archived, :boolean
  end
end
