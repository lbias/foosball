class Match < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy

  validates_length_of :teams, is: 2

  def add(grouped_players)
    teams.each_with_index do |team, index|
      team.player_ids = grouped_players[index].map(&:id)
    end
  end

  def add_players_by(player_ids)
    if player_ids.size == 2
      grouped_players = player_ids.map { |_, ids| User.find(ids) }
      add(grouped_players)
    end
  end
end
