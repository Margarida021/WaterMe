class AddWateringToPlant < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :watering, :string
  end
end
