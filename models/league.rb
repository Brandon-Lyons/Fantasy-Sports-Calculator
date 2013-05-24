class League < ActiveRecord::Base
	validates_uniqueness_of :name, :scope => :user
	has_many :user_leagues, :dependent => :delete_all
	has_many :users, through: :user_leagues
end