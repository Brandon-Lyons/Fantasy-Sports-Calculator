class CreateUserTable < ActiveRecord::Migration

	def change
    create_table :users do |t|
      t.string :user_id
      t.string :password
    end
  end
end