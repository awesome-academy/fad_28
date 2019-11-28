class Ability
  include CanCan::Ability

  def initialize user
    can :read, [Product, Suggest]
    if user.present?
      can [:read, :update, :evaluates, :orders, :suggests], User, id: user.id
      can :manage, [Evaluate, Suggest], user_id: user.id
      can :manage, Order, email: user.email
      if user.admin?
        can :manage, [Category, Product, Payment]
        can :create, User
        can :destroy, User, :customer?
        can :read, [Order, Suggest]
        can :admin_seen, Suggest
      end
    else
      can :read, [Product, Suggest]
    end
  end
end
