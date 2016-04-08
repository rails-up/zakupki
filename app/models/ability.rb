class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.persisted? 
      #Purchases
      can [:read, :create], Purchase
      can [:update, :destroy], Purchase, owner: user
    else  #guest
      can :read, Purchase
    end
  end
end
