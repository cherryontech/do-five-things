Rails.application.routes.draw do
  get 'inertia-example', to: 'inertia_example#index'
  post 'inertia-example', to: 'inertia_example#increase_counter'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "tasks#index"
  get "/tasks", to: "tasks#index"

  get 'settings', to: 'settings_page#index'
  get 'today', to: 'today_page#index'
  get 'progress', to: 'progress_page#index'
end
