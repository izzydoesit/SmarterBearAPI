Rails.application.routes.draw do
  resources :forms, only: ['index']
  resources :companies, only: ['index', 'show']
  resources :insiders, only: ['index', 'show']

  resources :companies do
    resources :images, only: ['show']
  end

  resources :images do
    
  end
  root 'companies#index'
end
