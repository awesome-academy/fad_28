Rails.application.routes.draw do
  scope "(:locale)" do
    root "home#index"

    get "signup", to: "users#new"
    resources :users, except: :new
<<<<<<< HEAD
    get "signin", to: "session#new"
    post "signin", to: "session#create"
    get "signout", to: "session#destroy"
=======
    get "signin" => "session#new"
    post "signin" => "session#create"
    get "signout" => "session#destroy"
>>>>>>> Sign in
  end
end
