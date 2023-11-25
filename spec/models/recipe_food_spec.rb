require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  # Test associations
  it { should belong_to(:recipe) }
  it { should belong_to(:food) }

  # Test validations
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  # Test the total_price method
  describe '#total_price' do
    let(:user) { create(:user) }
    let(:food) { create(:food, user: user, price: 5) }
    let(:recipe) { create(:recipe, user: user) }
    let(:recipe_food) { create(:recipe_food, recipe: recipe, food: food, quantity: 3) }

    it 'returns the correct total price based on quantity and food price' do
      expect(recipe_food.total_price).to eq(15) # 3 (quantity) * 5 (unit price)
    end
  end
end
