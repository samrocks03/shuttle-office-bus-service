# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    # role.name == "admin"
    # admin = role.find_by(name: "admin")


    if user.admin? #This will contain admin role
      can :manage, :all
    elsif user.employee? # User role
      can [:create], User
      can [:update,:read ], User, user_id: user.id
      cannot [:read, :delete], User

      cannot :manage, Bus # user cannot manage buses
      cannot :manage, Company # user cannot manage companies
      cannot [:create, :delete, :update], Schedule # user cannot manage schedules

      can :read, Schedule # user can read schedule
      can [:create, :read], Reservation, user_id: user.id # can view only his reservation
      cannot [:update, :destroy], Reservation # User cannot update or delete reservations
    else
      # Default guest abilities
      cannot :manage, :all
    end
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
