Rails.application.routes.draw do
  # devise routes for user authentication with custom controllers
  devise_for :users, controllers: {
    passwords: 'users/passwords'
  }
  
  # user management routes (exclude devise paths)
  resources :users, only: [:index, :show, :new, :create, :edit, :update], constraints: { id: /\d+/ }

  # settings route for logged-in users
  resource :settings, only: [:edit, :update]

  # blog routes with nested comments routes
  resources :blogs do
    # comment routes inside blog
    resources :comments, only: [:index, :create, :destroy]
    # route for publishing blog
    member do
      get :publish
      patch :publish
    end
    # routes for separate listing pages
    collection do
      get :published
      get :unpublished
    end
  end

  # helth check route
  get "up" => "rails/health#show", as: :rails_health_check

  # setting blogs as home page
  root "blogs#index"
end
