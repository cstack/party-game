class RoomUser < ApplicationRecord
	belongs_to :room
	belongs_to :user
	before_create :set_color

	def set_color
		self.color ||= room.next_color
	end

	def name
		user.name
	end
end
