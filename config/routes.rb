Pepemail::Application.routes.draw do
  resources :campaigns

  root :to => "home#index"
  match 'coupons' => 'home#coupons'
  devise_for :users
  resources :users

  resources :items do
    resources :campaigns
    resources :photos
  end
end
