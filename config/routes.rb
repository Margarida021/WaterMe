Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing"
  get "home", to: "pages#home"
  get "onboarding", to: "pages#onboarding"

  resources :divisions do
    resources :plant_divisions, only: [:new, :create]
  end

  resources :plants do
    resources :plant_divisions, only: [:new, :create]
  end

  post "plant_rec", to: "plants#api"

  resources :plant_divisions, only: [:show, :destroy]
  resources :waterings, only: [:create]
end
