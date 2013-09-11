Pepemail::Application.routes.draw do
  resources :contacts
  root :to => "home#index"
  devise_for :users
end
