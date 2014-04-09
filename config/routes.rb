Locallyv2::Application.routes.draw do

  resources :sites, only:[ :index ]
  resources :trips #:defaults => {:format => 'json'}

  scope(path_names: {new: 'sign_in'}) do
    resources :sessions, only: [:new, :create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :show, :destroy]
  
  root "site#index"
  
end
