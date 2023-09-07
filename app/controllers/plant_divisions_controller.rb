class PlantDivisionsController < ApplicationController
  before_action :set_plant_division, only: [:show, :edit, :update, :destroy]

  def new
    if params[:plant_id]
      @plant = Plant.find(params[:plant_id])
    else
      @division = Division.find(params[:division_id])
    end
      @plant_division = PlantDivision.new
  end

  def create
    @plant_division = PlantDivision.new(plant_division_params)

    if params[:plant_id]
      @plant = Plant.find(params[:plant_id])
      @plant_division.plant = @plant
    else
      @division = Division.find(params[:division_id])
      @plant_division.division = @division
    end

    if @plant_division.save
      if Date.today.strftime('%A') == params[:water][:last_watered_day]
        watered_day = Date.today
      else
        watered_day = Date.today.prev_occurring(params[:water][:last_watered_day].downcase.to_sym)
      end

      Watering.create(water_date: watered_day, plant_division: @plant_division)

      redirect_to division_path(@plant_division.division)
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
  end


  def edit
  end

  def update
    @plant_division.update(plant_division_params)
    redirect_to plant_divisions_path
  end

  def destroy
    @plant_division.destroy
    redirect_to division_path(@plant_division.division), status: :see_other
  end

  private

  def set_plant_division
    @plant_division = PlantDivision.find(params[:id])
  end

  def plant_division_params
    params.require(:plant_division).permit(:plant_id, :division_id)
  end
end
