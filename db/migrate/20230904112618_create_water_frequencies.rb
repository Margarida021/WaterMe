class CreateWaterFrequencies < ActiveRecord::Migration[7.0]
  def change
    create_table :water_frequencies do |t|
      t.string :frequency

      t.timestamps
    end
  end
end
