class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_admin
      can :manage, :all
    elsif user.role? :sales
      can :manage, [Machine, Payment]
    elsif user.role? :retailer
      can :read, [Machine]
      # manage products, assets he owns
      can :manage, Machine do |machine|
        machine.try(:owner) == user
      end
      can :manage, Document do |document|
        document.try(:owner) == user
      end
    end
  end
end
