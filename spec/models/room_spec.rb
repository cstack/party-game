require "rails_helper"

RSpec.describe Room, :type => :model do
	let(:instance) { described_class.new(users: users) }
	let(:users) { [user1, user2] }
  let(:user1) { User.new(name: 'user1') }
  let(:user2) { User.new(name: 'user2') }

  describe 'new_game!' do
  	subject { instance.new_game!(template: template) }
  	let(:template) { 'movie' }

    it 'initializes game correctly' do
      expect(subject).to be_a(Game)
      expect(subject.users).to eq(users)
      expect(subject.stories.count).to eq(users.count)
      expect(subject.game_users.count).to eq(users.count)
    end

    context 'given a bad template' do
      let(:template) { 'invalid' }

      it 'raises error' do
        expect { subject }.to raise_error('Validation failed: Template is not included in the list')
      end
    end
  end
end