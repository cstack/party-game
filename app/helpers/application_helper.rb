module ApplicationHelper
	def broadcast_user_joined_room(user:, room:)
		Rails.logger.info("DEBUG - broadcast_user_joined_room")
		RoomUser.find_or_create_by(user: user, room: room).broadcast_append_to room
	end
end
