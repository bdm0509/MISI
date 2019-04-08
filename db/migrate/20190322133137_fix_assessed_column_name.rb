class FixAssessedColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tax_certificates, :assessed, :tax_description
  end
end
