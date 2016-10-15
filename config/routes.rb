Rails.application.routes.draw do
  resources :transactions, only: ['index']

  root 'companies#index'
end
