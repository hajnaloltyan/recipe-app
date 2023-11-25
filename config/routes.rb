# config/routes.rb

# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes for health checks
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'recipes#public_recipes'

  devise_for :users

  get 'public_recipes', to: 'recipes#public_recipes'

  # Shopping list route
  # Define this before `resources :foods` to avoid conflict with `show` action
  post '/foods/shopping_list', to: 'foods#shopping_list', as: :shopping_list

  # Recipes routes
  resources :recipes do
    resources :recipe_foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    member do
      patch :toggle_public
    end
  end

  # Foods routes
  # Define standard CRUD routes for foods
  resources :foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]

end
