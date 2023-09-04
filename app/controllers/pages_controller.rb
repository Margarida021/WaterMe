class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing

  def home
    @today_weekday = Date.today.strftime('%A')
    plants_to_be_watered_today = current_user.plant_divisions.joins(plant: { water_frequency: :weekdays}).where('weekdays.day = ?', @today_weekday)
    plants_watered = plants_to_be_watered_today.joins(:waterings).where(waterings: { water_date: Date.today })
    @plants_not_watered = plants_to_be_watered_today - plants_watered
  end

  def landing
  end

end
