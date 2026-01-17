Rails.application.routes.draw do
  # blog routes with nested comments routes
  resources :blogs do
    # comment routes inside blog
    resources :comments, only: [:index, :create, :destroy]
    # route for publishing blog
    member do
      get :publish
      patch :publish
    end
  end

  # helth check route
  get "up" => "rails/health#show", as: :rails_health_check

  # setting blogs as home page
  root "blogs#index"
end
