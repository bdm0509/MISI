class FixAssessedOwnerColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tax_certificates, :addressed_owner, :assessed_owner
  end
end
