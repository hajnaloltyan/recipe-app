class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    return if @recipe.is_public? || @recipe.user == current_user

    redirect_to root_path
  end
end
