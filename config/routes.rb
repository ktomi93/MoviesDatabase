Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "application#home", as: "home"
  get '/search/', to: "application#search", as: "search_movie"
  get '/discover/', to: "application#home", as: "discover"

end
