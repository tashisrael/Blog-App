Rails.application.routes.draw do
  get "users", to: "users#index" 
  get "users/:id", to: "users#show", as: "user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
