class RenameUserleaguesTable < ActiveRecord::Migration

	def change
		rename_table(:userleagues, :user_leagues)
	end
end