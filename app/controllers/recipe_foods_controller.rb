class RecipeFoodsController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods
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
      food.user = current_user
      food.quantity = recipe_food_params[:quantity]
    end

    if @food.save
      @recipe_food = @recipe.recipe_foods.build(food: @food, quantity: recipe_food_params[:quantity])
      @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient added to recipe successfully.'
    else
      puts "Food could not be saved: #{@food.errors.full_messages}"
      @recipe_food = RecipeFood.new
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @food = @recipe_food.food

    if @food.update(name: recipe_food_params[:food_name], measurement_unit: recipe_food_params[:measurement_unit],
                    price: recipe_food_params[:price]) && @recipe_food.update(quantity: recipe_food_params[:quantity])
      redirect_to @recipe, notice: 'Ingredient updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy
    redirect_to @recipe, notice: 'Ingredient removed from recipe successfully.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_name, :quantity, :measurement_unit, :price)
  end
end
