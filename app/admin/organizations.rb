ActiveAdmin.register Organization do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :secret
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  sidebar "Details", only: :show do
    panel "Enterprise Configuration" do
      if(organization.enterprise_configuration.present?)
        div link_to("\##{organization.enterprise_configuration.id} enterprise_configuration", admin_enterprise_configuration_path(organization.enterprise_configuration))
      else
        div link_to("create enterprise_configuration", new_admin_enterprise_configuration_path({:enterprise_configuration => {:organization_id => organization.id}})) do |f|
        end
      end
    end
  end


end
