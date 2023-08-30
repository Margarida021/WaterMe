class CareGuide < ApplicationRecord
  belongs_to :plant

  validates :plant_id, presence: true
end
