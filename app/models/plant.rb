class Plant < ApplicationRecord
  has_many :plant_divisions
  has_many :divisions, through: :divisions
  has_one :care_guide, dependent: :destroy
  belongs_to :water_frequency

  validates :name, :scientific_name, :description, :photo_url, presence: true
end
