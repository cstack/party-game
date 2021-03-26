class Game < ApplicationRecord
	belongs_to :room
	has_many :movie_assignments
	has_many :movies
	has_many :game_users
	has_many :users, through: :game_users

	VALID_STATUSES = ['waiting_for_players', 'started']

  validates :status, inclusion: { in: VALID_STATUSES }

	after_initialize :set_default_status

	def set_default_status
		self.status ||= 'waiting_for_players'
	end

	def start!
		room.users.each do |user|
			users << user
			movie_assignments << MovieAssignment.new(movie: Movie.new, user: user)
		end
		self.status = 'started'
		save!
	end

	def movie_for(user)
		movie_assignments.find_by(user: user).movie
	end
end
