# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :categories, except: [:show]
  resources :events

  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :settings, only: [:edit, :update]

  get "/location", to: "location#get"

  root "static_pages#home"
end
