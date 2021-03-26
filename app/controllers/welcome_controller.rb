class WelcomeController < ApplicationController
	def index
		@user = current_user
		@room = Room.new
	end
end
