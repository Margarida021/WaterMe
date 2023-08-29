class AddPerenualIdToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :perenual_id, :integer
  end
end
