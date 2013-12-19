Pepemail::Application.routes.draw do
  

  

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get "public/show"

  resources :campaigns, :synq

  root :to => "home#index"
  get 'coupons' => 'home#coupons'  
  get "/campaigns/:id/preview" => "campaigns#preview", :as => "campaign_preview", via: [:get]
  devise_for :users
  resources :users

  resources :items do
    resources :campaigns
    resources :photos
  end
end
