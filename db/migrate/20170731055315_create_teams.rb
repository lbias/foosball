class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :color
      t.integer :match_id
      t.timestamps
    end
  end
end
