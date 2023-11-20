class Recipe < ApplicationRecord
    belongs_to :user
    has_many :recipe_foods
    has_many :foods, through: :recipe_foods

    validates :name, :preparation_time, :cooking_time, :description, presence: true
    validates :preparation_time, :cooking_time, numericality: { greater_than: 0 }
    validates :is_public, inclusion: { in: [true, false] }
  end
  