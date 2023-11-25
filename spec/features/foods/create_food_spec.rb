require 'rails_helper'

RSpec.feature 'Create Food', type: :feature do
  scenario 'User creates a new food item' do
    # Assuming user authentication is required
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit new_food_path

    fill_in 'Name', with: 'Banana'
    fill_in 'Measurement unit', with: 'pcs'
    fill_in 'Price', with: '0.5'
    fill_in 'Quantity', with: '10'
    click_button 'Create Food'

    expect(page).to have_content('Food was successfully added.')
    expect(Food.find_by(name: 'Banana')).not_to be_nil
  end
end
