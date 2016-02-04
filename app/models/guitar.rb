class Guitar < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :make, :model, :year
end