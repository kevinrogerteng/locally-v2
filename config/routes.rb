Locallyv2::Application.routes.draw do

  get '/api/yelps', to: "yelps#yelp_search", as: :yelp_search

  resources :mains, only:[:index]

  resources :sites, only:[ :index ]

  resources :trips do
    resources :activities, only: [:index, :create, :show, :update, :destroy]
  end

  resources :sessions, only: [:create, :destroy]

  resources :users, only:[:create, :update, :show, :destroy]
  
  root to: "sites#index"
  
end
