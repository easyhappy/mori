class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
    end
  end
end
