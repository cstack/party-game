class Room < ApplicationRecord
	has_one :game
	has_many :room_users
	has_many :users, through: :room_users
end
