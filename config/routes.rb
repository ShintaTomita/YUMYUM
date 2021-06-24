Rails.application.routes.draw do


  namespace :yumyum do
    get 'cards/new'
  end
  get 'cards/new'
  devise_for :chefs, :controllers => {
    :sessions =>           "chefs/sessions"
  }
  devise_scope :chefs do
    get "chefs/sign_in",   :to => "chefs/sessions#new"
    get "chef/sign_out",   :to => "chefs/sessions#destroy"
  end
  devise_for :users, :controllers => {
      :sessions =>         'users/sessions',
      :passwords =>        'users/passwords'
    }
  devise_scope :user do
    get "sign_in",         :to => "users/sessions#new"
    get "sign_out",        :to => "users/sessions#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :yumyum do
    root "top#index"
    get "search",          :to => "recipes#search"
    resources :top,        only: [:index]
    resources :users,      except: [:index]
    get "users/card/:id",      :to => "users#card"
    resources :chefs
    get "chef_recipes/:id", :to => "chefs#chef_recipes"
    resources :recipes do
      resources :orders,     only: [:create]
    end
    get "recipes/detail/:id",  :to => "recipes#detail"
    resources  :products
    resources  :cards,     only: [:new, :create]
  end

end
