Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index", as: :home
  get "/admin", to: "sessions#show"
  get "/dashboard", to: "menu#dash"
  get "/all_orders", to: "order#display"
  get "/sales_report", to: "order#sales"
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/clear", to: "cart_items#clear", as: :destroy_cart
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  resources :users
  resources :menu
  resources :menu_items
  resources :order
  resources :order_items
  resources :cart_items
end
