class RecipesController < ApplicationController
  def index
    # @recipes = current_user.recipes
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    return if @recipe.is_public? || @recipe.user == current_user

    redirect_to root_path
  end

  def public_recipes
    @public_recipes = Recipe.where(is_public: true)
  end
end
