# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :admin do
    resources :players
    resources :venues
    resources :users
  end

  root to: 'home#index'
  get :dashboard, to: 'dashboard#index'
end
