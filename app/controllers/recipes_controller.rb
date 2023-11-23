class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes]
  before_action :set_recipe, only: [:show, :destroy, :toggle_public]

  def index
    @recipes = current_user.recipes
  end

  def show
    return if @recipe.is_public? || @recipe.user == current_user

    redirect_to root_path
  end

  def public_recipes
    @public_recipes = Recipe.where(is_public: true)
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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
