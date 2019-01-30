class EnterpriseConfiguration < ApplicationRecord
	belongs_to :organization

	validates :organization_id, :presence => true, :uniqueness => true

end
