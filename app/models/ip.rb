# == Schema Information
#
# Table name: ips
#
#  id          :bigint(8)        not null, primary key
#  cidr        :string
#  ipable_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ipable_id   :bigint(8)
#
# Indexes
#
#  index_ips_on_ipable_type_and_ipable_id  (ipable_type,ipable_id)
#

class Ip < ApplicationRecord
  belongs_to :ipable, polymorphic: true

  after_save :refresh_ip_whitelist_cache

  validates :cidr, cidr_format: true
  validates :ipable, presence: true

  def refresh_ip_whitelist_cache
    if ipable_type.eql?("EnterpriseConfiguration")
      Rails.cache.delete_matched("**:#{self.ipable.id}:whitelist")
    end
  end
end
