class FoodsController < ApplicationController
  before_action :authenticate_user!, only: [:shopping_list]

  def index
    @foods = current_user.foods.includes(:recipe_foods)
  end

  def show
    if params[:id] == 'shopping_list'
      shopping_list
      render :shopping_list
    else
      @food = current_user.foods.find(params[:id])
    end
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully added.'
    else
      render :new
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    if @food.recipe_foods.any?
      redirect_to foods_path, alert: 'Cannot delete food that is part of a recipe.'
    else
      @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    end
  end

  def shopping_list
    @missing_foods = calculate_missing_foods
    @total_items = @missing_foods.count
    @total_value = @missing_foods.sum { |food| food[:price] * food[:quantity_needed] }
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def calculate_missing_foods
    # This is where the N+1 query problem can arise, so it should include both :foods and :recipe_foods
    user_recipes = current_user.recipes.includes(recipe_foods: :food)

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
