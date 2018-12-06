# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, only: [:index, :show]
  resources :identities
  devise_for :users
  resources :users, only: [:index, :destroy]
  root to: 'identities#index'
end
