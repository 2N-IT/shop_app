# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  namespace :admin do
    resources :products
    resources :orders
    get 'home', to: 'home#index'
  end
  resources :products
  resources :orders do
    member do
      get :confirmed
    end
  end
  resources :carts, only: %i[update destroy show]
end
