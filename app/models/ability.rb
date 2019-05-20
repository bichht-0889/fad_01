class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :index, :show, to: :read

    can :read, :all # permissions for every user, even if not logged in
    if user.present?
      can :create, [Comment, Sugest, User]
      can [:update, :show, :edit], User, user_id: user.id
      can [:read, :update, :show], Order, user_id: user.id
      can [:update, :show, :edit], :cart
      can :destroy, :session
      if user.admin?  # additional permissions for administrators
        can :manage, :all
      end
    else
      can :create, :registration
      can :create, :session
    end
  end
end
