# frozen_string_literal: true

Rails.application.routes.draw do
  get "/clients/eligibility", to: "clients#eligibility", constraints: { format: 'json' }
  resources :clients, only: %i[index show]
  resources :identities
  devise_for :users
  resources :users, only: [:index, :destroy]
  root to: 'identities#index'
end
