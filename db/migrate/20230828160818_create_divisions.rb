class CreateDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.string :light_direction

      t.timestamps
    end
  end
end
