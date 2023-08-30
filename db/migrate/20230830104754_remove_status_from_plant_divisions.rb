class RemoveStatusFromPlantDivisions < ActiveRecord::Migration[7.0]
  def change
    remove_column :plant_divisions, :status, :string
  end
end
