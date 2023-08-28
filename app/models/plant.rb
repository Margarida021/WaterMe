class Plant < ApplicationRecord
  has_many :plant_divisions
  has_many :divisions, through: :divisions

  validates :name, :scientific_name, :description, :photo_url, :watering, :light_level, presence: true
end
