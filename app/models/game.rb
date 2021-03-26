class Game < ApplicationRecord
	belongs_to :room
	has_many :movie_assignments
	has_many :movies, through: :movie_assignments
	has_many :game_users
	has_many :users, through: :game_users
	has_many :votes, through: :movies

	VALID_STATUSES = ['waiting_for_players', 'started']

  validates :status, inclusion: { in: VALID_STATUSES }

	after_initialize :set_default_status

	def set_default_status
		self.status ||= 'waiting_for_players'
	end

	def record_vote!(user:, movie:)
		Vote.create!(user: user, movie: movie)
		if all_votes_collected?
			# broadcast_replace_to room
		end
	end

	def all_movies_complete?
		movies.all?(&:complete?)
	end

	def all_votes_collected?
		votes.map(&:user_id).uniq.sort == users.map(&:id).uniq.sort
	end

	def movie_for(user)
		raise "user is nil" if user.nil?
		movie_assignments.find_by(user: user).movie
	end

	def best_picture
		movies.max_by(&:num_votes)
	end
end
