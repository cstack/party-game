class User < ApplicationRecord
	has_many :room_users
	has_many :rooms, through: :room_users

	after_initialize :set_token_and_name
	def set_token_and_name
		self.token ||= SecureRandom.hex(5)
		self.name ||= self.token
	end
end
