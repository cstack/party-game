class Room < ApplicationRecord
	has_many :games
	has_many :room_users
	has_many :users, through: :room_users

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

	def game
		games.where.not(status: 'finished').last
	end

	def previous_games
		games.where(status: 'finished')
	end

	def templates
		Template::KEYS.map do |key|
			Template.new(key)
		end
	end

	def new_game!(template:)
		new_game = Game.create!(room: self, users: users, status: 'started', template: template)
		users.each do |user|
			story = Story.create!(game: new_game)
			story.create_first_blank!
			Assignment.create!(story: story, user: user, game: new_game)
		end
		new_game
	end

	def finish_game!
		game.update!(status: 'finished')
	end

	attr_reader :viewer
	def from_perspective_of(user)
		@viewer = user
		self
	end

	def viewing_as_leader?
		viewer == leader
	end

	def leader
		users.first
	end
end
