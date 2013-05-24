class User < ActiveRecord::Base
	has_many :user_leagues
	has_many :leagues, through: :user_leagues
	validates_uniqueness_of :user_id
end