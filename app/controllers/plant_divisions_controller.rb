class PlantDivisionsController < ApplicationController

  def new
    @plant_division = PlantDivision.new
  end

  def create
    @divisions = Division.where(user_id: current_user.id)
    @plant_division = PlantDivision.new(plant_divisions_params)
    # The below is necessary? Or simple forms shows only the divisions of the current user?
    @plant = Plant.find(params[:plant_id])

    @plant_division.plant_id = @plant
    @plant_division.save
  end

  private

  def plant_divisions_params
    params.require(:plant_division).permit(:division_id)
  end
end
