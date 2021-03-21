class User < ApplicationRecord
	has_many :room_users
	has_many :rooms, through: :room_users

	after_initialize :set_token_and_name
	after_update_commit -> { Rails.logger.info("User after_update_commit broadcast_update_to"); room_users.each { |room_user| room_user.broadcast_replace_to room_user.room } }

	def set_token_and_name
		self.token ||= SecureRandom.hex(5)
		self.name ||= self.token
	end
end
