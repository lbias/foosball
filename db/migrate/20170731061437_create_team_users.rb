class CreateTeamUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_users do |t|
      t.index [:user_id, :team_id]
      t.index [:team_id, :user_id]
      t.timestamps
    end
  end
end
