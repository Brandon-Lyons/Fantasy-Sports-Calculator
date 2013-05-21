class ChangeLeagueColumns < ActiveRecord::Migration

	def change
		rename_column(:leagues, :touchdown, :pass_td)
		rename_column(:leagues, :yards, :pass_yards)
		rename_column(:leagues, :turnover, :int)
		rename_column(:leagues, :twopoint, :pass_2pt)
	end
end