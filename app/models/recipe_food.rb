class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # Calculate the total price of the food item based on its quantity and the unit price of the food
  def total_price
    quantity * food.price
  end
end
