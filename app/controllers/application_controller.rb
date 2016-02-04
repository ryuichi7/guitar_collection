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

end