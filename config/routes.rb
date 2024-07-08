Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :users, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :groups

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

  get 'about', to: 'pages#about'

  root 'pages#home'
end
