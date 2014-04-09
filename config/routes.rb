Locallyv2::Application.routes.draw do
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  resources :sites, only:[ :index ]
  resources :trips #:defaults => {:format => 'json'}

  scope(path_names: {new: 'sign_in'}) do
    resources :sessions, only: [:new, :create, :destroy]
  end

  root "site#index"
  
end
