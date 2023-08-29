class PlantDivisionsController < ApplicationController
  before_action :set_plant_division, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @plant_division.update(plant_division_params)
    redirect_to plant_divisions_path
  end

  def destroy
    @restaurant.destroy
    redirect_to plant_division_path, status: :see_other
  end

  private

  def set_plant_division
    @plant_division = PlantDivision.find(params[:id])
  end

  def plant_division_params
    params.require(:plant_division).permit(:photos)
  end
end
