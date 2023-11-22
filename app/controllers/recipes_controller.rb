class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes]

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    return if @recipe.is_public? || @recipe.user == current_user

    redirect_to root_path
  end

  def public_recipes
    @public_recipes = Recipe.where(is_public: true)
  end

  def new
    @recipe = Recipe.new
  end
end
