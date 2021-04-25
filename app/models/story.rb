class Story < ApplicationRecord
	has_many :blanks
	has_many :votes
	belongs_to :game
	has_one :assignment

	after_initialize :set_token
	def set_token
		self.token ||= SecureRandom.hex(5)
	end

	def to_param
		token
	end

	class << self
		def find(id)
			find_by(token: id) || find_by(id: id)
		end
	end

	def user
		assignment.user
	end

	def template
		Template.new(game.template)
	end

	def fill_in_the_blank(value:, user:)
		blanks.last.update!(value: value, user: user)
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
		blanks.create!(key: template.first_blank_key)
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

	def title_blank
		blanks.find_by(key: 'title')
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

	def tweet_link
		"https://twitter.com/intent/tweet?text=#{ERB::Util.url_encode(tweet_text)}"
	end

	def tweet_text
		"https://pitchparty.games/stories/#{token} - #{text}"
	end

	def text
		"#{title} - #{blanks_to_render.map(&:text).join(" ").strip}"
	end
end
