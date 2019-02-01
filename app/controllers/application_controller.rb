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

  def firewall
    if !is_admin? && !@organization.firewall.allow?(request)
      render plain: "Bad ip. Your ip is #{request.remote_ip}"
    end
  end

  private

  def is_admin?
    current_user.present? && current_user.is_admin?
  end
end
