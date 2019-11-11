Rails.application.routes.draw do
  scope "(:locale)" do
    root "home#index"

    get "signup", to: "users#new"
    resources :users, except: [:new, :edit]
    get "signin", to: "session#new"
    post "signin", to: "session#create"
    get "signout", to: "session#destroy"
    get "forget/password", to: "reset_password#new"
    post "forget/password", to: "reset_password#create"
    resources :reset_password, only: [:edit, :update]
    resources :change_password, :change_avatar, only: :update
    get "admin", to: "admin#index"
    resources :categories, except: :show
    resources :products
    resources :stores, only: :index do
      collection do
        get :food, :drink
      end
    end
    resources :payments, except: [:show, :new, :edit]
    resources :carts, only: :index
    resources :order_items, only: [:create, :update, :destroy]
  end
end
