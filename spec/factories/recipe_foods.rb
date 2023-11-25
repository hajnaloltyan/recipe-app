FactoryBot.define do
    factory :recipe_food do
      quantity { 1 }
      recipe
      food
    end
  end