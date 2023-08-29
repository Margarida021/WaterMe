class PlantDivision < ApplicationRecord
  belongs_to :plant
  belongs_to :division
  has_many_attached :photos

  validates :division_id, :plant_id, presence: true
end
