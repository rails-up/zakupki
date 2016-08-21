class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      method="#{user.roles.last.name}_abilities"
      self.send(method.to_sym) if self.respond_to?(method.to_sym)
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities

    can :manage, [Order, Comment], user: user
    can [:update, :destroy], [Purchase], owner: user
    can [:edit, :update], [User], id: user.id
    can :toggle_group, Group
  end

  def organizer_abilities
    user_abilities

    can :manage, [Purchase], owner: user
    can :change_state, Purchase, owner: user
    can :read, :all
  end

  def moderator_abilities
    can :manage, [Group, Purchase, Order]
    can [:edit, :update], [User]
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def banned_abilities
    cannot :manage, :all
  end
end
