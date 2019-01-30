class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

	has_one :organization#, :dependent => :destroy keep the org please

	after_create :create_organization

end
