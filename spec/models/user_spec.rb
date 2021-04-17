require "rails_helper"

RSpec.describe User, :type => :model do
	let(:instance) { described_class.new(name: name) }
	let(:name) { 'test' }

  describe 'validations' do
  	subject { instance }
  	it { is_expected.to be_valid }

  	context 'nil name' do
  		let(:name) { nil }
  		it { is_expected.to be_valid }
  	end

  	context 'name too long' do
  		let(:name) { "A"*281 }
  		it 'is not valid' do
  			expect(subject).not_to be_valid
  			expect(subject.errors[:name]).to include("is too long (maximum is 50 characters)")
  		end
  	end
  end
end