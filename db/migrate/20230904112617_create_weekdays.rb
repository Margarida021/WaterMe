class CreateWeekdays < ActiveRecord::Migration[7.0]
  def change
    create_table :weekdays do |t|
      t.string :day
      t.timestamps
    end
  end
end
