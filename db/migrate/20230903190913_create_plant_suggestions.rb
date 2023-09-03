class CreatePlantSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :plant_suggestions do |t|
      t.string :name
      t.string :scientific_name
      t.string :photo_url
      t.integer :perenual_id

      t.timestamps
    end
  end
end
