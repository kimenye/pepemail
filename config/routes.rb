Pepemail::Application.routes.draw do
  resources :contacts, :admin
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
end
