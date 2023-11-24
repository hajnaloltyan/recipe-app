require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Recipes Index Page', type: :system do
  fixtures :users, :recipes

  before do
    user = users(:one)
    sign_in user
  end

  it 'shows title of the page' do
    visit '/recipes'
    expect(page).to have_content 'My Recipes'
  end

  it 'displays all recipes for user one' do
    visit '/recipes'
    expect(page).to have_content 'Tomato Pasta'
  end

  it 'show option to add new recipe' do
    visit '/recipes'
    expect(page).to have_link('New Recipe', href: new_recipe_path)
  end

  it 'shows recipe details after clicking on recipe' do
    visit '/recipes'
    click_on 'Tomato Pasta'
    expect(page).to have_content 'Tomato Pasta'
  end
end
