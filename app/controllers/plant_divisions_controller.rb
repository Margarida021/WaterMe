class PlantDivisionsController < ApplicationController

  before_action :set_plant_division, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def new
    @plant_division = PlantDivision.new
  end

  def create
    @plant_division = PlantDivision.new(plant_division_params)
    if @plant_division.save
      redirect_to division_path(@plant_division.division)
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:plant_division).permit(:plant_id, :division_id)
  end
end
