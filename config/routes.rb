Rails.application.routes.draw do
  scope "(:locale)" do
    root "home#index"

    get "signup", to: "users#new"
    resources :users, except: :new
  end
end
