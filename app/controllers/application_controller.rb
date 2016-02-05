require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
    set :session_secret, "guitar_hero"
    set :public_folder, 'app/public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

	helpers do
		def logged_in?
			!!current_user
		end

		def current_user
			user ||= User.find_by_id(session[:id])
		end

		def login_failure
			@message = "You must login to view content"
			erb :'users/login'
		end

		def update_message
			session[:message] = "Successfully updated"
		end

	end

end