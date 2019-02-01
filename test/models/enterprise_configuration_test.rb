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

require 'test_helper'

class EnterpriseConfigurationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
