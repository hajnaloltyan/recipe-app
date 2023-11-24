require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Recipes Index Page', type: :system do
  fixtures :users, :recipes

  before do
    user = users(:one)
    sign_in user
  end

  it 'displays all recipes for user one' do
    visit '/recipes'
    expect(page).to have_content 'My Recipes'
    expect(page).to have_content 'Tomato Pasta'
    expect(page).to have_link('New Recipe', href: new_recipe_path)
  end
end
