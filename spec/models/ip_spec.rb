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

require 'rails_helper'

RSpec.describe Ip, type: :model do
  describe "cidr validation" do
    let(:conf) { EnterpriseConfiguration.new }
    subject { Ip.new(cidr: cidr, ipable: conf) }

    context "valid" do
      context "normal" do
        let(:cidr) { "1.1.1.1" }

        it { expect(subject.valid?).to be_truthy }
      end

      context "with supernet" do
        let(:cidr) { "1.1.1.1/24" }

        it { expect(subject.valid?).to be_truthy }
      end

      context "with mask" do
        let(:cidr) { "1.1.1.1 255.255.255.0" }

        it { expect(subject.valid?).to be_truthy }
      end
    end

    context "invalid" do
      context "some mess" do
        let(:cidr) { "foo" }

        it { expect(subject.valid?).to be_falsey }
      end

      context "invalid range" do
        let(:cidr) { "256.255.255.255" }

        it { expect(subject.valid?).to be_falsey }
      end

      context "invalid supernet range" do
        let(:cidr) { "1.1.1.1/45" }

        it { expect(subject.valid?).to be_falsey }
      end
    end
  end
end
