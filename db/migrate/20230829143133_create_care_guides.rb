class CreateCareGuides < ActiveRecord::Migration[7.0]
  def change
    create_table :care_guides do |t|
      t.text :watering
      t.text :sunlight
      t.text :pruning
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
