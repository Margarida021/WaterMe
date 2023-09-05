class AddWaterFrequencyToPlants < ActiveRecord::Migration[7.0]
  def change
    add_reference :plants, :water_frequency, null: false, foreign_key: true
  end
end
