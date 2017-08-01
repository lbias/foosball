class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :score1, default: 0, null: false
      t.integer :score2, default: 0, null: false
      t.integer :match_id
      t.integer :winner_id

      t.timestamps null: false
    end
  end
end
