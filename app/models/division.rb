class Division < ApplicationRecord
  belongs_to :user
  has_many :plant_divisions, dependent: :destroy

  CATEGORIES = ['Living Room', 'Bedroom', 'Kitchen', 'Patio', 'Bathroom', 'Hall', 'Balcony', 'Terrace', 'Office']
  LIGHT_DIRECTIONS = { 'Darker' => '0 hours of sunlight',
                        'Shade' => 'A site far away from a window, or a north-facing window',
                        'Part sun' => 'Dappled sun throughout the day',
                        'Full sun' => 'At least 8h of full sun'
                      }
  validates :category, inclusion: { in: CATEGORIES }
  validates :light_direction, inclusion: { in: LIGHT_DIRECTIONS.keys }
  validates :name, :category, :user_id, :light_direction, presence: true
end
