class CreateWaterings < ActiveRecord::Migration[7.0]
  def change
    create_table :waterings do |t|
      t.date :water_date
      t.references :plant_division, null: false, foreign_key: true

      t.timestamps
    end
  end
end
