class AddAttributesToTaxCertificates < ActiveRecord::Migration[5.1]
  def change
    add_column :tax_certificates, :addressed_owner, :string
    add_column :tax_certificates, :assessed, :text
    add_column :tax_certificates, :additional_information, :text
    add_column :tax_certificates, :date, :string
    add_column :tax_certificates, :fee, :string
    add_column :tax_certificates, :cad_value, :string
  end
end
