Rails.application.routes.draw do
  devise_for :users

  root to: "pages#landing"

  get "home", to: "pages#home", as: :home

  resources :divisions

  resources :plants do
    resources :plant_divisions
  end

  resources :plant_divisions
end
