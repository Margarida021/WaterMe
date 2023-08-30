Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing"
  get "home", to: "pages#home", as: :home
  resources :divisions do
    resources :plant_divisions, only: [:new, :create]
  end
 
  resources :plants do
    resources :plant_divisions, only: [:new, :create]
  end


end
