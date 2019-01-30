# == Schema Information
#
# Table name: enterprise_configurations
#
#  id              :bigint(8)        not null, primary key
#  app_name        :string(255)
#  subdomain       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#

class EnterpriseConfiguration < ApplicationRecord
	belongs_to :organization

	validates :organization_id, :presence => true, :uniqueness => true

end
