Rails.application.routes.draw do
  root to: 'home#index'

  resources :cats
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :cats do
    member do
      get 'delete'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
