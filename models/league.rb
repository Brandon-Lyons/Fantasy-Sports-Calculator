class League < ActiveRecord::Base
	validates_uniqueness_of :name
	belongs_to :user
end