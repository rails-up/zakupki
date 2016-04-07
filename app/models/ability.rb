class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      #Purchases
      can [:create, :read], Purchase
      can [:update, :delete], Purchase, owner: user

    end
  end
end
