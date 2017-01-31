Rails.application.routes.draw do
  root to: 'home#index'

  namespace :setup do
    resources :configs, only: [:index]
  end

  get 'auth/new',     as: :login
  get 'auth/remove',  as: :logout
  get 'auth/callback'

  resources :transactions, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
