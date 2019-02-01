# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(email: 'mail@example.com', password: 'password', password_confirmation: 'password', :confirmed_at => DateTime.now) if Rails.env.development?
ec = EnterpriseConfiguration.create!({
  organization: user.organization
})
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

#
#Create IP whitelist for local net
#

Ip.create!(cidr: "127.0.0.1/24", ipable: ec)
