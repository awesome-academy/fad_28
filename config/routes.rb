Rails.application.routes.draw do
  scope "(:locale)" do
    root "home#index"

    get "signup", to: "users#new"
    resources :users, except: :new
    get "signin", to: "session#new"
    post "signin", to: "session#create"
    get "signout", to: "session#destroy"
  end
end
