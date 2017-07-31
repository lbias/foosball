class Team < ApplicationRecord
  has_many :team_users
  has_many :players, through: :team_users, class_name: 'User', source: :user

  COLORS = %w(red blue)

  validate :players_limit

  def name
    players.map(&:name).join(' & ')
  end

  private

  def players_limit
    if players.size > 2
      errors.add(:players, "can't has more then 2 players")
    end
  end
end
