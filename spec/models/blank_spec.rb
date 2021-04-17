require "rails_helper"

RSpec.describe Blank, :type => :model do
	let(:instance) { described_class.new(story: story, value: value) }
	let(:story) { Story.new }
	let(:value) { 'test' }

  describe 'validations' do
  	subject { instance }
  	it { is_expected.to be_valid }

  	context 'nil value' do
  		let(:value) { nil }
  		it { is_expected.to be_valid }
  	end

  	context 'value too long' do
  		let(:value) { "A"*281 }
  		it 'is not valid' do
  			expect(subject).not_to be_valid
  			expect(subject.errors[:value]).to include("is too long (maximum is 280 characters)")
  		end
  	end
  end
end