Rails.application.routes.draw do
  resources :forms, only: ['index']

  root 'companies#index'
end
