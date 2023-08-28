class RemoveLightLevelFromPlantDivisions < ActiveRecord::Migration[7.0]
  def change
    remove_column :plant_divisions, :light_level, :string
  end
end
