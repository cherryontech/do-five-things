Rails.application.routes.draw do
  passwordless_for :users
  # Defines the root path route ("/")
  root 'settings_page#index'

  get 'settings',   to: 'settings_page#index'
  post 'settings',  to: 'settings_page#bulk_update'

  get 'today',      to: 'tasks/today#index'
  patch 'today',    to: 'tasks/today#edit'

  get 'progress',   to: 'progress_page#index'

  get 'inertia-example', to: 'inertia_example#index'
  post 'inertia-example', to: 'inertia_example#increase_counter'

  get 'login', to: 'sessions/login_page#index'
  post 'login', to: 'sessions/login_page#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
