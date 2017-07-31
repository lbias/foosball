class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :score1, default: 0, null: false
      t.integer :score2, default: 0, null: false
      t.references :match, index: true, foreign_key: true
      t.references :games, :winner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
