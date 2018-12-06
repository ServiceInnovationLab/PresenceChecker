# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, only: [:index]
  devise_for :users
  resources :users
  root to: 'clients#index'
end
