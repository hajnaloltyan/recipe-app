require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Public Recipes Page', type: :system do
  fixtures :users, :recipes

  it 'shows title of the page' do
    visit '/public_recipes'
    expect(page).to have_content 'Public Recipes'
  end

  it 'displays all public recipes' do
    visit '/public_recipes'
    expect(page).to have_content 'Tomato Pasta'
    expect(page).to have_content 'Chocolate Cake'
  end

  it 'does not show private recipes' do
    visit '/public_recipes'
    expect(page).not_to have_content 'Pizza'
  end

  it 'shows the owner of the recipe' do
    visit '/public_recipes'
    expect(page).to have_content 'By: Hajnal'
    expect(page).to have_content 'By: Cristian'
  end
end
