class Plant < ApplicationRecord
  has_many :plant_divisions
  has_many :divisions, through: :divisions
end
