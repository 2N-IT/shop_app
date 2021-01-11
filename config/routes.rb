# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  namespace :admin do
      resources :products
      get 'home', to: 'home#index'
  end
  resources :products
end
