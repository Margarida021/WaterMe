class CreateWaterFrequencyWeekdays < ActiveRecord::Migration[7.0]
  def change
    create_table :water_frequency_weekdays do |t|
      t.references :water_frequency, null: false, foreign_key: true
      t.references :weekday, null: false, foreign_key: true

      t.timestamps
    end
  end
end
