class Story < ApplicationRecord
	has_many :blanks
	has_many :votes
	belongs_to :game
	has_one :assignment

	def user
		assignment.user
	end

	def template
		Template.new(game.template)
	end

	def fill_in_the_blank(value)
		blanks.last.update!(value: value)
	end

	def undo_fill_in_the_blank!
		blanks.last.update!(value: nil)
	end

	def complete?
		on_last_blank? && !waiting_for_input?
	end

	def filling_out_first_blank?
		blanks.count == 1 && blanks.first.value.nil?
	end

	def partly_filled_out?
		!complete? && !filling_out_first_blank?
	end

	def partly_filled_out_message
		template.partly_filled_out_message
	end

	def on_last_blank?
		template.key_after(blanks.last.key).nil?
	end

	def waiting_for_input?
		blanks.last.value.nil?
	end

	def next_key
		template.key_after(blanks.last&.key)
	end

	def create_first_blank!
		blanks << Blank.new(key: template.first_blank_key)
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
			blanks.where.not(key: 'title').sort_by(&:position)
		else
			blanks.sort_by(&:position)
		end
	end
end