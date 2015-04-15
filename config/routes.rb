Rails.application.routes.draw do
  # Sessions
  resources :sessions, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new', as: :signin
  delete 'signout', to: 'sessions#destroy', as: :signout

  # Users
  resources :users do
    resources :marathons, except: [:show, :index]
  end
  get 'signup', to: 'users#new', as: :signup

  # Static Pages
  get 'help', to: 'static_pages#help', as: :help
  root 'static_pages#home'
end
