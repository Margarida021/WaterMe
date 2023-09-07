class PlantDivision < ApplicationRecord
  belongs_to :plant
  belongs_to :division
  #has_many_attached :photos
  has_many :waterings, dependent: :destroy

  validates :division_id, presence: true


  def self.watered(user)
    to_be_watered_today(user).joins(:waterings).where(waterings: { water_date: Date.today })
  end

  def self.not_watered(user)
    to_be_watered_today(user) - PlantDivision.watered(user)
  end

  def self.to_be_watered_today(user)
    today_weekday = Date.today.strftime('%A')
    user.plant_divisions.joins(plant: { water_frequency: :weekdays}).where('weekdays.day = ?', today_weekday)
  end
end
