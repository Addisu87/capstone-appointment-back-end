# class Ability
#   include CanCan::Ability

#   def initialize(user)
#     user ||= User.new

#     return unless user.present?

#     can :read, :all

#     return unless user.admin?

#     can :manage, User, user_id: user.id
#     can :manage, Motorcycle, user_id: user.id
#     can :manage, Reservation, user_id: user.id
#   end
# end
