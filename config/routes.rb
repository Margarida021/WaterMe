Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing"
  get "onboarding", to: "pages#onboarding"
  get "home", to: "pages#home"

  resources :divisions do
    resources :plant_divisions
  end

  resources :plants do
    resources :plant_divisions
  end

  post "plant_rec", to: "plants#api"

  resources :plant_divisions
  resources :waterings, only: [:create]
end
