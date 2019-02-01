# == Schema Information
#
# Table name: organizations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  secret     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_organizations_on_user_id  (user_id)
#

class Organization < ApplicationRecord
  belongs_to :user
  has_one :enterprise_configuration, :dependent => :destroy

  delegate :ip_whitelist, to: :enterprise_configuration, allow_nil: true

  after_initialize :set_defaults

  def app_name
    return "devday" if(enterprise_configuration.try(:app_name).blank?)
    return enterprise_configuration.app_name
  end

  def set_defaults
    self.secret = SecureRandom.hex(16) if(self.secret.blank?)
  end

  def enterprise?
    self.enterprise_configuration.present?
  end

  def firewall
    @firewall ||= TheBestFirewallYouWillEverNeed.new(self)
  end
end
