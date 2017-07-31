require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:match) { build(:match) }

  describe '#add' do
    let(:players) { (1..4).map { create(:user) } }

    it { expect(subject).to respond_to(:add) }
    it 'add players to teams of match' do
      match.add(players.in_groups(2))
      expect(match.players).to match_array(players)
    end
  end

  describe 'validations' do

    context 'teams' do
      it { expect(subject).to respond_to(:teams) }
      it 'has 2 teams with players' do
        match = create(:match)
        expect(match).to be_valid
        expect(match.teams.size).to eq(2)
      end
    end

    it 'is invalid if has less or more than 2 teams' do
      match.teams << build(:team)
      match.valid?
      expect(match.errors[:teams].any?).to be true
    end

    it 'is invalid with the same player in both teams' do
      user = create(:user)
      match.add([user, user].in_groups(2))
      match.valid?
      expect(match.errors[:player]).to include "can't participate both teams"
    end
  end

  describe '#ended?' do
    let(:match) { create(:match) }

    it { expect(subject).to respond_to(:ended?) }

    it 'returns true when one team won twice' do
      match.games.create(score: '10:8')
      expect(match.ended?).to be false

      match.games.create(score: '8:10')
      expect(match.ended?).to be false

      match.games.create(score: '10:8')
      expect(match.ended?).to be true
    end

  end
end
