class Room < ApplicationRecord
	has_many :games
	has_many :room_users
	has_many :users, through: :room_users

	def game
		games.last
	end

	def new_game!
		Game.create!(room: self, users: users, status: 'started')
		users.each do |user|
			game.users << user
			movie = Movie.create!(game: game)
			movie.create_first_blank!
			MovieAssignment.create!(movie: movie, user: user, game: game)
		end
	end

	attr_reader :viewer
	def from_perspective_of(user)
		@viewer = user
		self
	end
end
