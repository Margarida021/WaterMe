Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :divisions

  resources :plants do
    resources :plant_divisions
  end

  resources :plant_divisions
end
