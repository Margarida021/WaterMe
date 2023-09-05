class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_variables
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    home_path(current_user) 
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end


  def set_variables
    @today_weekday = Date.today.strftime('%A')
    plants_to_be_watered_today = current_user.plant_divisions.joins(plant: { water_frequency: :weekdays}).where('weekdays.day = ?', @today_weekday)
    @plants_watered = plants_to_be_watered_today.joins(:waterings).where(waterings: { water_date: Date.today })
    @plants_not_watered = plants_to_be_watered_today - @plants_watered
  end

end
