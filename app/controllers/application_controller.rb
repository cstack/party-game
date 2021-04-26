class ApplicationController < ActionController::Base
	before_action :current_user # make sure @current_user is set
	before_action :set_debug
	around_action :redirect_from_heroku

	DEBUG = false

	rescue_from StandardError do |exception|
		Bugsnag.notify(exception)
    raise exception
  end

  def default_url_options
    if Rails.env.production?
      { host: "www.pitchparty.games"}
    else
      {}
    end
  end
	
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
  	@debug = DEBUG
  end

	def redirect_from_heroku
		if request.host.include?('herokuapp.com')
			redirect_to :status => :found, :host => "www.pitchparty.games#{path}"
		else
			yield
		end
	end
end
