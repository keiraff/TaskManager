# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :categories, except: [:show]

  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  root "static_pages#home"
end
