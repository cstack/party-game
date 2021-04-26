class Game < ApplicationRecord
	belongs_to :room
	has_many :assignments
	has_many :stories, through: :assignments
	has_many :game_users
	has_many :users, through: :game_users
	has_many :votes, through: :stories

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

	VALID_STATUSES = ['waiting_for_players', 'started', 'finished', 'cancelled']
  validates :status, inclusion: { in: VALID_STATUSES }
	after_initialize :set_default_status
	def set_default_status
		self.status ||= 'waiting_for_players'
	end

  validates :template, inclusion: { in: Template::KEYS }
	after_initialize :set_default_template
	def set_default_template
		self.status ||= 'movie'
	end

	def template_object
		Template.new(template)
	end

	def record_vote!(user:, story:)
		Vote.create!(user: user, story: story)
		if all_votes_collected?
			# broadcast_replace_to room
		end
	end

	def ready_to_advance_turn?
		stories.none?(&:waiting_for_input?)
	end

	def advance_turn!
		stories.each do |story|
			next_blank = story.create_next_blank!
		end
		rotate_assignments!
	end

	def rotate_assignments!
		sorted_assignments = assignments.sort_by(&:id)
		story_ids = sorted_assignments.map(&:story_id)
		story_ids = story_ids.drop(1) + [story_ids.first]
		sorted_assignments.zip(story_ids).each do |assignment, story_id|
			assignment.update!(story_id: story_id)
		end
	end

	def all_stories_complete?
		stories.all?(&:complete?)
	end

	def has_vote?(user)
		votes.find_by(user: user).present?
	end

	def waiting_for_vote?(user)
		all_stories_complete? && !has_vote?(user)
	end

	def all_votes_collected?
		votes.map(&:user_id).uniq.sort == users.map(&:id).uniq.sort
	end

	def story_for(user)
		raise "user is nil" if user.nil?
		assignments.find_by(user: user).story
	end

	def winner
		stories.max_by(&:num_votes)
	end

	def includes_player?(user)
		users.include?(user)
	end

	def voting_title
		template_object.voting_title
	end

	def user_list
		users.uniq.sort_by(&:id)
	end

	def status_for_user(user)
		if story_for(user).waiting_for_input? || waiting_for_vote?(user)
			"🤔"
		else
			"✅"
		end
	end

	def color_for(user)
		room.room_users.find_by(user: user).color
	end

	def turn_number
		counts = stories.map do |story|
			story.blanks.count
		end.uniq
		if counts.length > 1
			# This is an invalid state, but don't break the game if this happens
			0
		else
			counts.first
		end
	end
end
