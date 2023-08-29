Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :plants do
    resources :plant_divisions
  end
end
