class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :price, :quantity, numericality: { greater_than: 0 }
end
