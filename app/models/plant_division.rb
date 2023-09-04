class PlantDivision < ApplicationRecord
  belongs_to :plant
  belongs_to :division
  #has_many_attached :photos
  has_many :waterings

  validates :division_id, presence: true
end
