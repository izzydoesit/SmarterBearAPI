Rails.application.routes.draw do
  resources :forms, only: ['index']
  resources :companies, only: ['index']
  resources :transactions, only: ['index']

  root 'companies#index'
end
