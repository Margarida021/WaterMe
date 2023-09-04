class RemoveWateringFreqFromPlants < ActiveRecord::Migration[7.0]
  def change
    remove_column :plants, :watering_freq
  end
end
