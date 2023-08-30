Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing"
  get "home", to: "pages#home", as: :home
  resources :divisions
  resources :plants 
  resources :plant_divisions
end
