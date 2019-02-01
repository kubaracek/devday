ActiveAdmin.register Ip, as: "Firewall Rule" do
  permit_params :cidr, :ipable_id, :ipable_type
  form do |f|
    f.object.ipable_type = "EnterpriseConfiguration"
    f.inputs do
      f.input :cidr
      f.input :ipable_id,
        as: :select,
        collection: EnterpriseConfiguration.all.map {|e| [e.id.to_s, e.id]}
      f.input :ipable_type, as: :hidden
    end
    f.actions
  end
end
