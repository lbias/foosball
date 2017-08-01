class User < ApplicationRecord
  validates_presence_of :last_name, :first_name

  has_many :team_users
  has_many :teams, through: :team_users
  has_many :matches, through: :teams
  has_many :games, through: :teams, source: :games

  scope :sorted, -> (flag = :asc) { order(first_name: flag) }
  scope :expirienced, -> { eager_load(:team_users => :team).group("users.first_name").order("count(team_users.user_id) desc")}

  def name
    [first_name, last_name].join(' ')
  end

  def won_matches
    matches.select { |match| match.winner.in?(teams)}
  end

  def matches_stat
    [matches.count, matches.select { |match| match.winner.present? && team_ids.include?(match.winner.id)}.count].join(' - ')
  end

  def best_partner
    User.joins(teams: [:match, :games])
        .group('users.id')
        .where.not(team_users: { user_id: id })
        .where(games: { winner_id: team_ids })
        .group('first_name')
        .order('count(games.winner_id) desc')
        .first
  end
end
