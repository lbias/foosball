require 'rails_helper'

RSpec.describe Game, type: :model do
  it { expect(subject).to respond_to(:match) }

  describe 'validations' do

    it 'is invalid with score more then 10' do
      expect(build(:game, score1: 11)).to_not be_valid
    end

    it 'is invalid with equal scores' do
      game = build(:game, score1: 5, score2: 5)
      game.valid?
      expect(game.errors[:scores].any?).to be true
    end
  end

  it '#score shows common score' do
    game = build(:game, score1: 3, score2: 10)
    expect(game.score).to eq('3:10')
  end

  it '#score= set scores' do
    game = build(:game, score: '3:6')
    expect([game.score1, game.score2]).to eq [3, 6]
  end
end
