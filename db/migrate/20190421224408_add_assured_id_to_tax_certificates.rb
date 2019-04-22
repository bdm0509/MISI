class AddAssuredIdToTaxCertificates < ActiveRecord::Migration[5.1]
  def change
    add_column :tax_certificates, :assured_id, :integer
  end
end
