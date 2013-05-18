class AddColumns < ActiveRecord::Migration

	def change
		add_column(:leagues, :rush_yards, :integer, default: 1)
		add_column(:leagues, :rush_td, :integer, default: 6)
		add_column(:leagues, :rush_2pt, :integer, default: 2)
		add_column(:leagues, :rec_yards, :integer, default: 1)
		add_column(:leagues, :rec_td, :integer, default: 6)
		add_column(:leagues, :rec_2pt, :integer, default: 2)
	end
end