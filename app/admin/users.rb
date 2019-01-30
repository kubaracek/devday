ActiveAdmin.register User do
	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# permit_params :list, :of, :attributes, :on, :model
	#
	# or
	#
	# permit_params do
	#   permitted = [:permitted, :attributes]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end


	sidebar "Details", only: :show do
		panel "Organization" do
			if(user.organization.present?)
				div link_to("\##{user.organization.id} #{user.organization.name}", admin_organization_path(user.organization))
			else
				div link_to("create organization", new_admin_organization_path({:organization => {:user_id => user.id}})) do |f|
				end
			end
		end
	end
end
