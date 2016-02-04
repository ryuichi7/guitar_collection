require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
    set :session_secret, "guitar_hero"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

	helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			User.find_by_id(session[:id])
		end

		def login_failure
			@error = "You must login to view content"
			erb :'users/login'
		end
	end

end