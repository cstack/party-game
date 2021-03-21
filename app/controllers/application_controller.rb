class ApplicationController < ActionController::Base
	before_action :set_current_user, only: %i[ show edit update destroy ]
	
	private

	def current_user
		current_user_token = session[:current_user_token]
    @_current_user ||= if current_user_token
			User.find_or_initialize_by(token: current_user_token)
		else
			user = User.new
			session[:current_user_token] = user.token
			user
		end
  end

  def set_current_user
  	@current_user = current_user
  end
end
