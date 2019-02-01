require 'rails_helper'

RSpec.describe 'TheBestFirewallYouWillEverNeed' do           #
  let(:whitelisted_cidrs) {
    [
      '1.1.1.1/24',
      '2.2.0.0 255.255.0.0',
      '3.0.0.0'
    ]
  }

  let(:ips) do
    whitelisted_cidrs.map do |cidr|
      Ip.new(cidr: cidr)
    end
  end

  let(:request) do
    req = double()
    req.stub(:remote_ip) { ip }
    req
  end

  shared_context "firewall" do |should_go_through|
    it 'should firewall' do
      expect(
        TheBestFirewallYouWillEverNeed.new(org).allow?(request)
      ).to eql(should_go_through)
    end
  end

  context 'Organization is not Enterprise' do
    let(:org) do
      Organization.new
    end

    context 'whitelisted ip' do
      let(:ip) { '3.0.0.0' }

      it_behaves_like "firewall", true
    end

    context 'whitelisted ip in range' do
      let(:ip) { '1.1.1.2' }

      it_behaves_like "firewall", true
    end

    context 'not whitelisted ip' do
      let(:ip) { '45.53.124.12' }

      it_behaves_like "firewall", true
    end
  end

  context 'Organization is enterprise' do
    let(:conf) do
      EnterpriseConfiguration.new(
        organization: Organization.new,
        ips: ips
      )
    end
    let(:org) { conf.organization }

    context 'whitelisted ip' do
      let(:ip) { '3.0.0.0' }

      it_behaves_like "firewall", true
    end

    context 'whitelisted ip in range' do
      let(:ip) { '1.1.1.2' }

      it_behaves_like "firewall", true
    end

    context 'whitelisted ip in mask range' do
      let(:ip) { '2.2.255.255' }

      it_behaves_like "firewall", true
    end

    context 'not whitelisted ip' do
      let(:ip) { '46.171.4.4' }

      it_behaves_like "firewall", false
    end
  end
end
