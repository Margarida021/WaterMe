class PlantDivisionsController < ApplicationController
  def new
    @plant = Plant.find(params[:plant_id])
    @plant_division = @plant.plant_divisions.build
    @divisions = Division.where(user_id: current_user.id)
  end

  def create
    @plant_division = PlantDivision.new(plant_divisions_params)
    # The below is necessary? Or simple forms shows only the divisions of the current user?
    @plant = Plant.find(params[:plant_id])

    @plant_division.plant_id = @plant
    if @plant_division.save
      redirect_to division_path(Division.find(params[:division_id]))
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def plant_divisions_params
    params.require(:plant_division).permit(:division_id)
  end
end
