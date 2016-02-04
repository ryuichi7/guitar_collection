class User < ActiveRecord::Base
	has_many :guitars
	has_many :amps
	has_many :pedals
	has_secure_password
	validates_presence_of :username, :email, :password_digest
end