Rails.application.routes.draw do
  passwordless_for :users, controller: 'sessions'

  get 'sign_up', to: 'users#new', as: :sign_up
  post 'sign_up', to: 'users#create'
  # Defines the root path route ("/")
  root 'settings#index'
  get 'settings',   to: 'settings#index'
  post 'settings',  to: 'settings#bulk_update'
  get 'today',      to: 'tasks/today#index'
  patch 'today',    to: 'tasks/today#edit'
  get 'progress',   to: 'progress#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
