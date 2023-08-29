class Plant < ApplicationRecord
  has_many :plant_divisions
  has_many :divisions, through: :divisions
  has_one :care_guide, dependent: :destroy

  validates :name, :scientific_name, :description, :photo_url, presence: true
  # validates :watering_freq, :light_level, presence: true
end
