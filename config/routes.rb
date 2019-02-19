# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, only: %i[index show] do
    resources :eligibilities
    # get 'eligibility/:day', to: 'clients#eligibility'
  end
  resources :identities
  devise_for :users
  resources :users, only: [:index, :destroy]
  root to: 'identities#index'
end
