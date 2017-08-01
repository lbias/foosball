class Game < ApplicationRecord
  belongs_to :match
  belongs_to :winner, class_name: 'Team'

  validates_numericality_of :score1, :score2, less_than_or_equal_to: 10
  validates_presence_of :winner

  before_validation :define_winner

  scope :winners, -> { joins(:winner) }

  def score
    [score1, score2].join(':')
  end

  def score=(score)
    self.score1, self.score2 = score.split(':')
  end

  private

  def define_winner
    errors.add(:match, "match is ended") if match.ended?
    if score1 == score2
      errors.add(:scores, "can't be equal")
    else
      index = score1 > score2 ? 0 : 1
      self.winner = match.teams[index]
    end
  end
end
