class Message < ApplicationRecord
  belongs_to :room
  after_create_commit -> { broadcast_append_to room }
end
