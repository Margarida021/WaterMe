class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :scientific_name
      t.text :description
      t.string :photo_url

      t.timestamps
    end
  end
end
