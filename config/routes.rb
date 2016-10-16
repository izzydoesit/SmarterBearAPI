Rails.application.routes.draw do
  resources :forms, only: ['index']
  resources :companies, only: ['index', 'show']
  resources :insiders, only: ['index', 'show']

  root 'companies#index'
end
