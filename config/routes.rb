Pepemail::Application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get "public/show"

  # resources :campaigns

  root :to => "home#index"
  get 'coupons' => 'home#coupons'  
  # get "/campaigns/:id/preview" => "campaigns#preview", :as => "campaign_preview", via: [:get]
  devise_for :users
  resources :users

  get "/track/:id/show" => "visits#show", :as => "track", via: [:get]
  get "/campaigns/:id/opt_in" => "campaigns#opt_in", :as => "optin", via: [:get]
  post "/campaigns/:id/decision" => "campaigns#decision", :as => "decision", via: [:post]
  get '/campaigns/:id/mms' => 'campaigns#mms', :as => "mms", via: [:get]

  resources :items do
    # resources :campaigns
    resources :photos
  end
end
