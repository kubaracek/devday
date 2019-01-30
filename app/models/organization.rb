class Organization < ApplicationRecord

	belongs_to :user
	has_one :enterprise_configuration, :dependent => :destroy

	after_initialize :set_defaults

	def app_name
		return "devday" if(enterprise_configuration.try(:app_name).blank?)
		return enterprise_configuration.app_name
	end

	def set_defaults
		self.secret = SecureRandom.hex(16) if(self.secret.blank?)
	end

end