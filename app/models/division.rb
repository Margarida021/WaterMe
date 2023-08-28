class Division < ApplicationRecord
  belongs_to :user
  has_many :plant_divisions, dependent: :destroy
end
