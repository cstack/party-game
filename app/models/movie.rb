class Movie < ApplicationRecord
	has_many :blanks
	has_many :votes
	belongs_to :game

	def fill_in_the_blank(value)
		blanks.last.update!(value: value)
	end

	def complete?
		on_last_blank? && !waiting_for_input?
	end

	def on_last_blank?
		Blank.key_after(blanks.last.key).nil?
	end

	def waiting_for_input?
		blanks.last.value.nil?
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
		blanks.find_by(key: key)&.value
	end

	def title
		get('title')
	end

	def num_votes
		votes.count
	end

	def blanks_to_render
		if title.present?
			blanks.where.not(key: 'title')
		else
			blanks
		end
	end
end
