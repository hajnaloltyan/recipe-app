# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes for health checks
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Define the root of your application
  root 'recipes#index'

  # Recipes routes
  resources :recipes do
    resources :recipe_foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  # Public recipes route
  get 'public_recipes', to: 'recipes#public_recipes'

  # Foods routes
  resources :foods, only: [:index, :show, :new, :create, :destroy]

  # Shopping list route
  # If the shopping list pertains to a user, consider nesting it within a user resource or scope
  get 'shopping_list', to: 'foods#shopping_list'

end
