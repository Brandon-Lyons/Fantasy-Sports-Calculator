class AddLeagueColumn < ActiveRecord::Migration

	def change
		add_column(:leagues, :user_id, :string)
	end
end