require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Recipes Show Page', type: :system do
  fixtures :users, :recipes

  before do
    user = users(:one)
    sign_in user
    @recipe = recipes(:one)
  end

  it 'shows the recipe details page' do
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content 'Tomato Pasta'
  end

  it 'shows the Preparation Time and Cooking Time' do
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content 'Preparation time: 1.0 hour(s)'
    expect(page).to have_content 'Cooking time: 2.0 hour(s)'
  end

  it 'shows the description of the recipe' do
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content 'This is a description'
  end
end
