Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    # 瀏覽餐廳所有動態
    collection do 
      get :feeds
      get :ranking
    end
    # 瀏覽個別餐廳的Dashboard
    member do 
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
  end

  namespace :admin do
    resources :categories
    resources :restaurants
    root "restaurants#index"
  end

  resources :categories, only: :show
  root "restaurants#index"

  resources :users, only: [:index, :show, :edit, :update]

  resources :followships, only: [:create, :destroy]

end
