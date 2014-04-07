Locallyv2::Application.routes.draw do
  
  resources :sites, only:[ :index ]

  root "site#index"
end
