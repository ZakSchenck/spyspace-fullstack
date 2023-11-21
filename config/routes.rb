Rails.application.routes.draw do
  get 'signup/create'
namespace :api, defaults: { format: 'json' } do
  namespace :v1 do 
    resources :posts do
    resources :replies
    end
  end
end

root to: "home#index"

post "refresh", controller: :refresh, action: :create
post "signin", controller: :signin, action: :create
post "signup", controller: :signup, action: :create
delete "signin", controller: :signin, action: :destroy
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
