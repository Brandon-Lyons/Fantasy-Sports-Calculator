require_relative 'bootstrap-ar'
require_relative 'interface'
require_relative 'login'
require_relative 'calculate'
require 'csv'
include Interface
include Login
include Calculate
# command = ARGV[0]

# if command == "add"
# 	league_name = ARGV[1]
# 	League.create(name: league_name)
# elsif command == "list"
# 	leagues = League.all
# 	leagues.each_with_index {|league, i| puts "#{i + 1}. #{league.name}"}
# elsif command == "delete"
# 	league = ARGV[1]
# 	deleted = League.where(name: league).all
# 	deleted.each do |item|
# 		item.destroy
# 	end
# end

intro
