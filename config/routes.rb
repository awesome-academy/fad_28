Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)" do
    root "home#index"

    resources :users do
      member do
        get :evaluates, :orders, :suggests
      end
    end
    resources :change_avatar, only: :update
    resources :admin, only: :index do
      collection do
        get :orders_by_day, :orders_by_week, :orders_by_month, :orders_by_year
        get :trash
      end
    end
    resources :categories, except: :show
    resources :products do
      member do
        get :restore, :hard_destroy
      end
    end
    resources :stores, only: :index do
      collection do
        get :food, :drink
      end
    end
    resources :payments, except: [:show, :new, :edit]
    resources :carts, only: [:index, :create]
    get "update", to: "carts#update_quantity"
    get "destroy", to: "carts#destroy_item"
    resources :orders do
      collection do
        get :places, :transports, :finishes
      end
    end
    resources :change_status, only: :update
    resources :evaluates, except: [:index, :show, :new]
    resources :suggests do
      collection do
        get :admin_view_new
      end
      member do
        get :admin_seen
      end
    end
  end
end
