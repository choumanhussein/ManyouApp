Rails.application.routes.draw do
  namespace :admin do
  resources :users
  end
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions
end
