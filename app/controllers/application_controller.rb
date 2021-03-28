class ApplicationController < ActionController::Base
	before_action :current_user # make sure @current_user is set
	before_action :set_debug
	around_action :log_everything

	DEBUG = false
	
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

  def log_everything
  	if DEBUG
  		log_headers
  		yield
  	else
  		yield
  	end
  end

	def log_headers
	  http_envs = {}.tap do |envs|
	    request.headers.each do |key, value|
	      envs[key] = value if key.downcase.starts_with?('http')
	    end
	  end

	  logger.info "DEBUG - Received #{request.method.inspect} to #{request.url.inspect} from #{request.remote_ip.inspect}. Processing with headers #{http_envs.inspect} and params #{params.inspect}"
	end

	def log_response
	  logger.info "DEBUG - Responding with #{response.status.inspect} => #{response.body.inspect}"
	end
end
