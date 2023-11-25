class RecipeFoodsController < ApplicationController
  # Ensure that a user is logged in before accessing recipe foods
  before_action :authenticate_user!

  def index
    # Find the recipe by its id and preload the associated recipe_foods and their related food objects
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:recipe_id])
    # This will now not cause an N+1 query when accessing food for each recipe_food in the views
    @recipe_foods = @recipe.recipe_foods
  end

  def show
    # Preload the food for the single recipe_food being shown
    @recipe_food = RecipeFood.includes(:food).find(params[:id])
  end
end
