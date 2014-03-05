class Nunchaku::Ability
  include CanCan::Ability

  attr_accessor :user, :session, :organisation, :permission_profile

  def initialize(user, organisation, session)
  	@user = user
  	@organisation = organisation
  	@session = session
  end
end