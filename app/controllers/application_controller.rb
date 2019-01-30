class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :load_organization
  before_action :load_enterprise_configuration

  def load_organization()
  	@organization = current_user.organization if(current_user.present?)
  end

  def load_enterprise_configuration()
  	@enterprise_configuration = @organization.enterprise_configuration if(current_user.present?)
  end

end
