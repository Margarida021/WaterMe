class AddLightLevelToPlant < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :light_level, :string
  end
end
