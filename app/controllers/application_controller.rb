class ApplicationController < ActionController::Base
	before_action :current_user # make sure @current_user is set
	before_action :set_debug
	
	private

	def current_user
    @current_user ||= if session[:current_user_token]
			User.find_or_create_by(token: session[:current_user_token])
		else
			user = User.create
			session[:current_user_token] = user.token
			user
		end
  end

  def set_debug
  	@debug = false
  end
end
