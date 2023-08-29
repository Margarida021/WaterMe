class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing

  def home
    @plants = Plant.all
  end

  def landing
  end

end
