# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, only: [:index ,:show]
  resources :identities
  devise_for :users
  root to: 'identities#index'
end
