class MovieAssignment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  belongs_to :game
end
