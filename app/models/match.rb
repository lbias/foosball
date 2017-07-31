class Match < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :games, dependent: :destroy

  validates_length_of :teams, is: 2
  validate :check_players_in_teams
  validate :consists_and_limit_players

  after_initialize :build_teams

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

  def players
    teams.map(&:players).flatten
  end

  def ended?
    winner.present?
  end

  def winner
    game_winners = games.map(&:winner)
    game_winners.detect {|winner| game_winners.count(winner) > 1}
  end

  def scores
    games.map(&:score).join(', ')
  end

  private

  def check_players_in_teams
    if players.detect{ |e| players.count(e) > 1 }
      errors.add(:player, "can't participate both teams")
    end
  end

  def build_teams
    return if teams.present?
    Team::COLORS.map do |color|
      teams.build(color: color)
    end
  end

  def consists_and_limit_players
    unless players.length.in?(2..4)
      errors.add(:players, 'should consist 2-4 for both teams')
    end
  end  
end
