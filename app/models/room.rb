class Room < ApplicationRecord
	has_one :game
	has_many :room_users
	has_many :users, through: :room_users
	after_initialize :ensure_game

	def ensure_game
		self.game ||= Game.new
	end
end
