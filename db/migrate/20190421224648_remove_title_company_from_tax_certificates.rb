class RemoveTitleCompanyFromTaxCertificates < ActiveRecord::Migration[5.1]
  def change
    remove_column :tax_certificates, :title_company
  end
end
