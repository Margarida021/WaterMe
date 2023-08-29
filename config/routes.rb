Rails.application.routes.draw do
  root to: "pages#landing"
  devise_for :users
  resources :divisions
  get "/home", to: "pages#home", as: :home
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :plants
end
