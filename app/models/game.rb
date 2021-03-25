class Game < ApplicationRecord
	belongs_to :room

	VALID_STATUSES = ['waiting_for_players', 'started']

  validates :status, inclusion: { in: VALID_STATUSES }

	after_initialize :set_default_status

	def set_default_status
		self.status ||= 'waiting_for_players'
	end
end
