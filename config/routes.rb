Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    delete 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end

  resources :groups do
    resources :messages, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :pets do
    resources :health_records, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    collection do
      get 'search'
    end
  end

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

  get 'about', to: 'pages#about'

  root 'pages#home'
end
