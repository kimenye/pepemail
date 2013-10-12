Pepemail::Application.routes.draw do
  root :to => "home#index"
  match 'coupons' => 'home#coupons'
  devise_for :users
  resources :users, :items
end
