class PlantDivisionsController < ApplicationController
  def show
    @plant_division = PlantDivision.find(params[:id])
  end

  def edit
    @plant_division = PlantDivision.find(params[:id])
  end

  def update
    @plant_division = PlantDivision.find(params[:id])
    @plant_division.update(plant_division_params)

  end

  def destroy
  end

  private

  def plant_division_params
    params.require(:plant_division).permit(:photos)
  end
end
