class AddColumnUser < ActiveRecord::Migration

	def change
		add_column(:leagues, :user, :string)
	end
end