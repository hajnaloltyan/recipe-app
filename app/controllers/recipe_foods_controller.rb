class RecipeFoodsController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find_or_create_by(name: recipe_food_params[:food_name]) do |food|
      food.measurement_unit = recipe_food_params[:measurement_unit]
      food.price = recipe_food_params[:price]
    end

    if @food.save
      @recipe_food = @recipe.recipe_foods.build(food: @food, quantity: recipe_food_params[:quantity])

      if @recipe_food.save
        redirect_to @recipe, notice: 'Ingredient added to recipe successfully.'
      else
        puts "RecipeFood is not valid: #{@recipe_food.errors.full_messages}"
        render :new
      end
    else
      puts "Food could not be saved: #{@food.errors.full_messages}"
      @recipe_food = RecipeFood.new
      render :new
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_name, :quantity, :measurement_unit, :price)
  end
end
