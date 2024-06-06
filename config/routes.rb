Rails.application.routes.draw do
  resources :users
  resources :accounts

  get "/accounts/:id/users", to:"accounts#users"
end
