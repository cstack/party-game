class RoomUser < ApplicationRecord
	belongs_to :room
	belongs_to :user
	# after_create_commit -> { broadcast_append_to room }
end
