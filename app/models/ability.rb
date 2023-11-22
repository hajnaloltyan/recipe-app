class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe, is_public: true

    return unless user

    can :create, Recipe
    can %i[update destroy], Recipe, recipe.user == user
  end
end
