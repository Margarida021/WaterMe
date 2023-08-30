Rails.application.routes.draw do
  root to: "pages#landing"
  devise_for :users

  resources :divisions

  resources :plants do
    resources :plant_divisions
  end

  resources :plant_divisions
end
