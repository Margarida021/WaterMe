class WaterFrequency < ApplicationRecord
  has_many :water_frequency_weekdays
  has_many :weekdays, through: :water_frequency_weekdays
end
