require 'rails_helper'

RSpec.describe Food, type: :model do
  # Test associations
  it { should belong_to(:user) }
  it { should have_many(:recipe_foods).dependent(:destroy) }

  # Test validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:measurement_unit) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:quantity) }

  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
end
