class CreateUserleagueTable < ActiveRecord::Migration

	def change
		create_table :userleagues do |t|
	      t.integer :user_id
	      t.integer :league_id
	    end
	    remove_column(:leagues, :user_id)
	end
end
