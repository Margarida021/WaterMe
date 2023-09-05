class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :onboarding]


  def home
  end

  def landing
  end

  def onboarding
  end

end
