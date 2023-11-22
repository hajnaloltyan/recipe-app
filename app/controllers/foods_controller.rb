class FoodsController < ApplicationController
    def index
      @foods = Food.all
    end
  
    def show
      @food = Food.find(params[:id])
    end

    def shopping_list
        @missing_foods = calculate_missing_foods
        @total_items = @missing_foods.count
        @total_value = @missing_foods.sum { |item| item[:price] * item[:quantity_needed] }
      end
    
      private
    
      def calculate_missing_foods
        # Fetch our recipes, inventory items, and calculate what's missing
        # We will need to adjust this logic to fit the application's models and associations
        # This is just a pseudocode example
        recipes = Recipe.includes(:foods).where(user: current_user)
        inventory = current_user.inventory_foods # Assuming we have a model for inventory items
      
        # Logic to determine what's missing from inventory to fulfill the recipe requirements
        # ...
      end      
  end
