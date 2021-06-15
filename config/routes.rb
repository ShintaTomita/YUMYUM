Rails.application.routes.draw do


  devise_for :chefs, :controllers => {
    :sessions => "chefs/sessions"
  }
  devise_scope :chefs do
    get "chefs/sign_in",      :to => "chefs/sessions#new"
    get "chef/sign_out",      :to => "chefs/sessions#destroy"
  end
  devise_for :users, :controllers => {
      :sessions =>  'users/sessions',
      :passwords => 'users/passwords'
    }
  devise_scope :user do
    get "sign_in",  :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :yumyum do
    root "top#index"
    resources :top,   only: [:index]
    resources :users, except: [:index]
    resources :chefs
  end

end
