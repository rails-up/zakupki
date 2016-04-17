class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :moderator
      can :manage, [Group, Purchase, Order]
      can [:edit, :update], [User]
      can :read, :all
    elsif user.has_role? :organizer
      can [:edit, :update, :destroy], [Purchase], user_id: user.id
      can [:edit, :update], [User], id: user.id
      can :create, [Purchase] # would create order?
      can :read, :all
    elsif user.has_role? :user
      can [:edit, :update, :destroy], [Order], user_id: user.id # @todo add Comment model
      can [:edit, :update], [User], id: user.id
      can [:update, :destroy], [Purchase], owner: user
      can :toggle_group, Group
      can :create, [Order]
      can :read, :all
    elsif user.has_role? :banned
      cannot :manage, :all
    else
      can :read, :all
    end
  end
end
