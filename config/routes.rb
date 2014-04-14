Locallyv2::Application.routes.draw do

  get '/api/yelps', to: "yelps#yelp_search", as: :yelp_search

  resources :sites, only:[ :index ]

  resources :trips do
    resources :activities, only: [:index, :create, :show, :update, :destroy]
  end

  scope(path_names: {new: 'sign_in'}) do
    resources :sessions, only: [:create, :destroy]
  end

  resources :users, only:[:create, :update, :show, :destroy]
  
  root to: "site#index"
  
end
