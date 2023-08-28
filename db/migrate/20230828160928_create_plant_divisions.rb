class CreatePlantDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :plant_divisions do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true
      t.string :light_level

      t.timestamps
    end
  end
end
