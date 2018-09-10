Rails.application.routes.draw do
  root to: 'home#index'

  namespace :setup do
    resource :config, only: [:show]
  end

  get 'auth/new',     as: :login
  get 'auth/remove',  as: :logout
  get 'auth/callback'

  resources :internal_transfers, only: [:new, :create, :show], path_names: { new: '' }
  resources :transactions, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
