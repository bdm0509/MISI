class AddDescriptionToDistrictType < ActiveRecord::Migration[5.1]
  def change
    add_column :district_types, :description, :string
  end
end
