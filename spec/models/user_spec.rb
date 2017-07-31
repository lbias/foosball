require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with first_name and last_name' do
      expect(build(:user)).to be_valid
    end

    it 'is invalid without first_name' do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include "can't be blank"
    end

    it 'is invalid without last_name' do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include "can't be blank"
    end

    it "returns a user's full name as a string" do
      user = build(:user, first_name: 'Sam', last_name: 'Walton')
      expect(user.name).to eq('Sam Walton')
    end
  end

  context 'played matches' do

    let!(:user) { create :user }
    let!(:other_user) { create :user }
    let!(:ended_match) { create(:match, :ended, users: [user, other_user]) }

    describe '#won_matches' do
      it { expect(subject).to respond_to(:won_matches) }

      it 'returns matches where player won' do
        expect(ended_match).to be_in(user.won_matches)
      end
    end
  end
end
