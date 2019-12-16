# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can %i(approve cancel destroy ticket trash restore), Booking

      can %i(destroy admin user), User
      cannot :destroy, User, id: user.id
    else
      can %i(destroy cancel), Booking, user_id: user.id
    end
    can %i(create read update), User, id: user.id
    can %i(create read update), Booking, user_id: user.id
  end
end
