class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can 
    end
  end
end
