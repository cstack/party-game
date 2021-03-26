module ApplicationHelper
	def broadcast_user_joined_room(user:, room:)
		Rails.logger.info("DEBUG - broadcast_user_joined_room")
		RoomUser.find_or_create_by(user: user, room: room).broadcast_append_to room
	end

	def broadcast_username_change(room_user:)
		Rails.logger.info("DEBUG - broadcast_username_change")
		room_user.broadcast_replace_to room_user.room
	end
end
