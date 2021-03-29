class Game < ApplicationRecord
	belongs_to :room
	has_many :movie_assignments
	has_many :movies, through: :movie_assignments
	has_many :game_users
	has_many :users, through: :game_users
	has_many :votes, through: :movies

	VALID_STATUSES = ['waiting_for_players', 'started', 'finished']
  validates :status, inclusion: { in: VALID_STATUSES }
	after_initialize :set_default_status
	def set_default_status
		self.status ||= 'waiting_for_players'
	end

	VALID_TEMPLATES = ['movie', 'startup']
  validates :template, inclusion: { in: VALID_TEMPLATES }
	after_initialize :set_default_template
	def set_default_template
		self.status ||= 'movie'
	end

	def record_vote!(user:, movie:)
		Vote.create!(user: user, movie: movie)
		if all_votes_collected?
			# broadcast_replace_to room
		end
	end

	def ready_to_advance_turn?
		movies.none?(&:waiting_for_input?)
	end

	def advance_turn!
		movies.each do |movie|
			next_blank = movie.create_next_blank!
		end
		rotate_movie_assignments!
	end

	def rotate_movie_assignments!
		assignments = movie_assignments.sort_by(&:id)
		movie_ids = assignments.map(&:movie_id)
		movie_ids = movie_ids.drop(1) + [movie_ids.first]
		assignments.zip(movie_ids).each do |assignment, movie_id|
			assignment.update!(movie_id: movie_id)
		end
	end

	def all_movies_complete?
		movies.all?(&:complete?)
	end

	def has_vote?(user)
		votes.find_by(user: user).present?
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
