class AddPlantdivisionstatusToPlantDivisions < ActiveRecord::Migration[7.0]
  def change
    add_column :plant_divisions, :status, :string
  end
end
