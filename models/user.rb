class User < ActiveRecord::Base
	has_many :leagues
	validates_uniqueness_of :user_id
end