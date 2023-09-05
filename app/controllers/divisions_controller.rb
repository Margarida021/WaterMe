class DivisionsController < ApplicationController
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  def index
    @divisions = Division.all
  end

  def show
  end

  def new
    @division = Division.new
  end

  def create
    @division = Division.new(division_params)
    @division.user = current_user
    if @division.save
      redirect_to division_path(@division)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    @division.update(division_params)
    redirect_to division_path(@division)
  end

  def destroy
    @division.destroy
    redirect_to divisions_path, status: :see_other
  end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def division_params
    params.require(:division).permit(:name, :category, :light_direction)
  end
end
