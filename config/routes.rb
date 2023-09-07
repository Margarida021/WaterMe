Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing"
  get "onboarding", to: "pages#onboarding"
  get "home", to: "pages#home"

  resources :divisions do
    resources :plant_divisions, only: [:new, :create, :edit]
  end

  resources :plants do
    resources :plant_divisions, only: [:new, :create, :edit]
  end

  post "plant_rec", to: "plants#api"

  resources :plant_divisions, only: [:show, :destroy, :edit]
  resources :waterings, only: [:create]
end
