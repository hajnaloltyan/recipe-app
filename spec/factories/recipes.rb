FactoryBot.define do
  factory :recipe do
    name { 'Test Recipe' }
    preparation_time { 30 }
    cooking_time { 60 }
    description { 'This is a test recipe description.' }
    is_public { true }
    user
  end
end
