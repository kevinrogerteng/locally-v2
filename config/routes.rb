Locallyv2::Application.routes.draw do

  resources :sites, only:[ :index ]
  resources :trips, only:[ :index, :create, :update, :destroy] do
    resources :activities, only: [:create, :show, :update, :destroy]
  end

  scope(path_names: {new: 'sign_in'}) do
    resources :sessions, only: [:create, :destroy]
  end

  resources :users, only:[:create, :update, :show, :destroy]
  
  root "site#index"
  
end
