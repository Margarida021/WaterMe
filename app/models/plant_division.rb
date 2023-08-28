class PlantDivision < ApplicationRecord
  belongs_to :plant
  belongs_to :division

  validates :division_id, :plant_id, presence: true
end
