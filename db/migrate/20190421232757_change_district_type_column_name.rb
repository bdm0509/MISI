class ChangeDistrictTypeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :district_types, :type, :type_string
  end
end
