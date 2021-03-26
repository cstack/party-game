class Movie < ApplicationRecord
	has_many :blanks
	has_many :votes
	belongs_to :game

	def fill_in_the_blank(value)
		blanks.last.update!(value: value)
		next_blank = create_next_blank!
	end

	def complete?
		blanks.last.value.present? && Blank.key_after(blanks.last.key).nil?
	end

	def next_key
		Blank.key_after(blanks.last&.key)
	end

	def create_first_blank!
		blanks << Blank.new(key: Blank.first_key)
	end

	def create_next_blank!
		key = next_key
		return if key.blank?
		blank = Blank.new(key: key)
		blanks << blank
		blank
	end

	def get(key)
		blanks.find_by(key: key).value
	end

	def title
		"Movie starring #{get('actor1')}"
	end

	def num_votes
		votes.count
	end
end
