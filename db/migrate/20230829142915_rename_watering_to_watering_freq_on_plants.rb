class RenameWateringToWateringFreqOnPlants < ActiveRecord::Migration[7.0]
  def change
    rename_column :plants, :watering, :watering_freq
  end
end
