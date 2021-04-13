class Assignment < ApplicationRecord
  belongs_to :story
  belongs_to :user
  belongs_to :game
end
