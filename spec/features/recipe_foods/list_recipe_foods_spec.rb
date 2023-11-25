require 'rails_helper'

RSpec.feature 'List Recipe Foods', type: :feature do
  scenario 'User views recipe foods and navigates to add a new ingredient' do
    # Create a single user and food
    user = FactoryBot.create(:user)
    food = FactoryBot.create(:food, user: user)
    recipe = FactoryBot.create(:recipe, user: user)

    # Create several recipe_food instances using the same user and food
    FactoryBot.create_list(:recipe_food, 3, recipe: recipe, food: food)

    login_as(user, scope: :user)

    visit recipe_recipe_foods_path(recipe)

    expect(page).to have_content('Recipe Foods for ' + recipe.name)
    expect(page).to have_selector('tr', count: 4)  # Including header row

    click_link 'Add Ingredient'
    expect(current_path).to eq(new_recipe_recipe_food_path(recipe))
  end
end
