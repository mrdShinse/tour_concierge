# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users
  root to: 'home#index'
  get :dashboard, to: 'dashboard#index'
end
