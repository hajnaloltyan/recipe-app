class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:shopping_list]

  def index
    @foods = current_user.foods
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def shopping_list
    @missing_foods = calculate_missing_foods
    @total_items = @missing_foods.count
    @total_value = @missing_foods.sum { |food| food[:price] * food[:quantity_needed] }
  end

  private

  def calculate_missing_foods
    user_recipes = current_user.recipes.includes(:foods)

    user_recipes.flat_map do |recipe|
      recipe.recipe_foods.map do |recipe_food|
        {
          food_name: recipe_food.food.name,
          quantity_needed: recipe_food.quantity,
          price: recipe_food.food.price
        }
      end
    end
  end
end
