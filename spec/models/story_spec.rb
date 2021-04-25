require "rails_helper"

RSpec.describe Story, :type => :model do
	let(:instance) { described_class.create(game: game) }
  let(:user) { User.new }
  let(:game) { Game.new(template: 'startup') }

  before do
    instance.create_first_blank!
    instance.fill_in_the_blank(value: 'blank1', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank2', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank3', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank4', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank5', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank6', user: user)
    instance.create_next_blank!
    instance.fill_in_the_blank(value: 'blank7', user: user)
  end

  describe 'text' do
  	subject { instance.text }
  	
    it 'is correct' do
      puts subject
      expect(subject).to eq(
        "blank7 - I’m working on a super stealth startup. It’s like blank1 but for blank2 . " \
        "Have you ever had the problem where blank3 ? Well, thanks to our blank4 technology , " \
        "you can just blank5 instead. We'll make money by blank6 .",
      )
    end
  end
end