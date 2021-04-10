module ApplicationHelper
	def broadcast_user_joined_room(user:, room:)
		Rails.logger.info("DEBUG - broadcast_user_joined_room")
		RoomUser.find_or_create_by(user: user, room: room).broadcast_append_to room
	end

	def broadcast_username_change(room_user:)
		Rails.logger.info("DEBUG - broadcast_username_change")
		room_user.broadcast_replace_to room_user.room
	end

	def broadcast_game_start(room:, current_user:)
		Rails.logger.info("DEBUG - broadcast_game_start")
		room.users.each do |user|
			next if user == current_user
			room.from_perspective_of(user).broadcast_replace_to "room_#{room.id}_user_#{user.id}"
		end
	end

	def broadcast_game_finish(room:)
		Rails.logger.info("DEBUG - broadcast_game_finish")
		room.users.each do |user|
			room.from_perspective_of(user).broadcast_replace_to "room_#{room.id}_user_#{user.id}"
		end
	end

	def broadcast_advance_turn(game:)
		Rails.logger.info("DEBUG - broadcast_advance_turn")
		game.users.each do |user|
			game.room.from_perspective_of(user).broadcast_replace_to "room_#{game.room.id}_user_#{user.id}"
		end
	end

	def broadcast_player_status_changed(game:, user:)
		Turbo::StreamsChannel.broadcast_replace_to game.room,
			target: "player_status_#{user.id}_#{game.id}",
			partial: "application/player_status",
			locals: { user: user, game: game }
	end

	def broadcast_all_votes_in(game:, current_user:)
		Rails.logger.info("DEBUG - broadcast_all_votes_in")
		game.users.each do |user|
			next if user == current_user
			game.room.from_perspective_of(user).broadcast_replace_to "room_#{game.room.id}_user_#{user.id}"
		end
	end
end
