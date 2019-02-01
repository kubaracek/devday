# lib/the_best_firewall_you_will_ever_need.rb
require 'ipaddr'

class TheBestFirewallYouWillEverNeed
  attr_accessor :organization, :cache

  def initialize(organization)
    @organization = organization
    @cache = Rails.cache
  end

  def allow?(request)
    ip = request.remote_ip

    return true unless self.organization.enterprise?
    return true unless self.organization.ip_whitelist.present?

    return is_allowed(ip: ip, cache: true)
  end

  private

  def is_allowed(ip:, cache: false)
    if cache
      cache_key = "#{ip}:#{self.organization.id}:whitelist"

      self.cache.fetch(cache_key) do
        check_ip_in_whitelist(ip, self.organization.ip_whitelist)
      end
    else
      check_ip_in_whitelist(ip, self.organization.ip_whitelist)
    end
  end

  # Whitelist ['cidr', 'cidr', ..]
  # where from and to are ips
  def check_ip_in_whitelist(ip, whitelist)
    whitelist.map do |whitelist_cidr|
      ip_in_range(ip, whitelist_cidr)
    end.any?
  end

  # Check if ip in CIDR
  # where ip is an ip address eg 192.168.1.1
  # where range is a valid CIDR
  def ip_in_range(ip, cidr)
    ip = IPAddr.new(ip).to_i

    NetAddr::IPv4Net
      .parse(cidr)
      .contains(NetAddr::IPv4.new(ip))
  end
end
