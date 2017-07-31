require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { build(:team) }

  describe 'validations' do
    it { expect(subject).to respond_to(:players) }

    context 'with players' do
      it 'is valid with 1 or 2 players' do
        2.times { team.players << build(:user) }
        expect(team).to be_valid
      end

      it 'is invalid more then 2 players' do
        3.times { team.players << build(:user) }
        team.valid?
        expect(team.errors[:players].any?).to be true
      end

    end

  end

  describe '#name' do
    it { expect(subject).to respond_to(:name) }
    it 'returns players names as string' do
      player1 = build(:user, first_name: 'Sam', last_name: 'Walton')
      player2 = build(:user, first_name: 'Jim', last_name: 'Collins')
      team.players << player1
      expect(team.name).to eq('Sam Walton')

      team.players << player2
      expect(team.name).to eq('Sam Walton & Jim Collins')
    end
  end
end
