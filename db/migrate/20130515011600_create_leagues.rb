class CreateLeagues < ActiveRecord::Migration

  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :touchdown, default: 6
      t.integer :yards, default: 1
      t.integer :turnover, default: -2
      t.integer :twopoint, default: 2
    end
  end
end