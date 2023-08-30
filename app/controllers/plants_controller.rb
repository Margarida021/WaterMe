class PlantsController < ApplicationController
  before_action :set_plant, only: %i[show]

  def index
    @plants = Plant.all

    if params[:query].present?
      sql_subquery = "name ILIKE :query OR scientific_name ILIKE :query"
      @plants = @plants.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def photo_search(plant_photo)
  end
end
