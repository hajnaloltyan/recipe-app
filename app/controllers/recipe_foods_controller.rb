class RecipeFoodsController < ApplicationController
    def index
      @recipe = Recipe.find(params[:recipe_id])
      @recipe_foods = @recipe.recipe_foods
    end
  
    def show
      @recipe_food = RecipeFood.find(params[:id])
    end
  end
  