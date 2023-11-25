class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes]
  before_action :set_recipe, only: %i[show destroy toggle_public]

  # Eager load the recipe_foods and foods to prevent N+1 query problems
  def index
    @recipes = current_user.recipes.includes(recipe_foods: :food)
  end

  def show
    # Here we are ensuring that when we set the recipe, we include the recipe_foods and foods
    # Check 'set_recipe' method for the eager loading
    return if @recipe.is_public? || @recipe.user == current_user

    redirect_to root_path
  end

  # Eager load the recipe_foods and foods for public recipes
  def public_recipes
    @public_recipes = Recipe.where(is_public: true).includes(recipe_foods: :food)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully added.'
    else
      render :new
    end
  end

  def toggle_public
    @recipe.update(is_public: !@recipe.is_public)
    redirect_to @recipe, notice: 'Recipe visibility updated.'
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :is_public)
  end

  # Ensure that when we find a recipe, we include the recipe_foods and foods to prevent N+1 queries
  def set_recipe
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
  end
end
