FactoryBot.define do
    factory :user do
      name { "testuser" }
      email { "test@example.com" }
      password { "password" }
      # Add any other required fields
    end
  end