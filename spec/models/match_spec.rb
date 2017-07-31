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
  end
end
