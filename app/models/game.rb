class Game < ApplicationRecord
  belongs_to :match
  belongs_to :winner, class_name: 'Team'

  validates_numericality_of :score1, :score2, less_than_or_equal_to: 10

  def score
    [score1, score2].join(':')
  end

  def score=(score)
    self.score1, self.score2 = score.split(':')
  end    
end
