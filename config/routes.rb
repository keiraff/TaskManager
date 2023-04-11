# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
