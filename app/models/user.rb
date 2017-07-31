class User < ApplicationRecord
  validates_presence_of :last_name, :first_name

  has_many :team_users
  has_many :teams, through: :team_users
  has_many :matches, through: :teams
  has_many :games, through: :teams, source: :games

  scope :sorted, -> (flag = :asc) { order(first_name: flag) }
  
  def name
    [first_name, last_name].join(' ')
  end
end
