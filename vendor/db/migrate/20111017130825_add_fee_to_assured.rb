class AddFeeToAssured < ActiveRecord::Migration
  def change
    add_column :assureds, :fee, :float
  end
end
