Rails.application.routes.draw do

  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:new, :create, :show]
  resources :sessions
  namespace :admin do
  resources :users, only:[:index, :edit, :update, :new, :create, :show, :destroy]
  end
end
