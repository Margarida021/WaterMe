class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :onboarding]

  def home
    @today_weekday = Date.today.strftime('%A')
    plants_to_be_watered_today = current_user.plant_divisions.joins(plant: { water_frequency: :weekdays}).where('weekdays.day = ?', @today_weekday)
    plants_watered = plants_to_be_watered_today.joins(:waterings).where(waterings: { water_date: Date.today })
    @plants_not_watered = plants_to_be_watered_today - plants_watered

    divisions = current_user.divisions
    @plants_placed_wrong = sun_rec(divisions)
  end

  def landing
  end

  def onboarding
  end

  private

  def sun_rec(divisions)
    plants_placed_wrong = []
    divisions.each do |division|
      division.plant_divisions.each do |plant_div|
        plants_placed_wrong << plant_div if division.light_direction != plant_div.plant.light_level
      end
    end
    plants_placed_wrong
  end
end
