class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # Calculate the total price of the food item based on its quantity and the unit price of the food
  def total_price
    # Ensure the food is preloaded to avoid N+1 queries
    raise 'Food must be preloaded' unless association(:food).loaded?

    quantity * food.price
  end
end
