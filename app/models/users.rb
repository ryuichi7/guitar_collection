class User < ActiveRecord::Base
	has_many :guitars
	has_many :amps
	has_many :pedals
	has_secure_password
	validates :username, :email, :password_digest, 
						:presence => { :message => "You must properly fill in all fields" }
end