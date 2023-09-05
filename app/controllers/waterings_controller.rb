class WateringsController < ApplicationController
  def create
    @plant_division = PlantDivision.find(params[:plant_division_id])
    @watering = Watering.new(plant_division: @plant_division, water_date: Date.today)
    @watering.save

    redirect_to home_path, notice: "Plant Watered!"
  end
end
