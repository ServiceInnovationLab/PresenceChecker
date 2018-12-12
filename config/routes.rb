# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, only: %i[index show] do
    get 'eligibility/:day', to: 'clients#eligibility', constraints: { format: 'json' }
  end
  resources :identities
  devise_for :users
  resources :users, only: [:index, :destroy]
  root to: 'identities#index'
end
