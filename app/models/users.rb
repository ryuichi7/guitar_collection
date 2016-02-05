class User < ActiveRecord::Base
	has_many :guitars
	has_many :amps
	has_many :pedals
	has_secure_password
	validates :username, :email, 
						:presence => { :message => "must be filled in properly" }
end