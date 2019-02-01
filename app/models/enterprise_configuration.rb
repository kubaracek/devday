# == Schema Information
#
# Table name: enterprise_configurations
#
#  id              :bigint(8)        not null, primary key
#  app_name        :string
#  subdomain       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#
# Indexes
#
#  index_enterprise_configurations_on_organization_id  (organization_id)
#
#

class EnterpriseConfiguration < ApplicationRecord
  belongs_to :organization
  has_many :ips, as: :ipable

  validates :organization_id, :presence => true, :uniqueness => true

  def ip_whitelist
    # This would normally be ips.pluck(:cid)
    ips.map(&:cidr)
  end
end
