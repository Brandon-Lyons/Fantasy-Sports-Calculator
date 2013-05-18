require 'test/unit'
require_relative '../bootstrap-ar'

module DatabaseClean
	def before_setup
		super
		League.destroy_all
	end
end