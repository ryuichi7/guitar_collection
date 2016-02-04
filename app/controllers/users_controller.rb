class UsersController < ApplicationController

	get '/users' do
		if logged_in?
	  	@users = User.all
			erb :'users/index'
		else
			redirect '/login'
		end
	end

	get '/login' do
		if !logged_in?
			erb :'users/login'
		else
			redirect '/users'
		end
	end

	get '/signup' do
		if !logged_in?
			erb :'users/signup'
		else
			redirect '/users'
		end
	end

	post '/signup' do
		@user = User.create(params)
		if @user.save
			session[:id] = @user.id
			redirect '/users'
		else
			redirect '/signup' #figure out how to add some error messages
		end
	end

	post '/login' do 
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/users'
		else
			redirect '/login' #figure eror message for login failure
		end
	end

	get '/logout' do
		session[:id].clear
		redirect '/logout' #some type of logout message
	end

	get '/users/show' do
		if logged_in?
			@guitars = []
			@amps = []
			@pedals = []
			erb :'users/show'
		else
			redirect '/login'
		end
	end
end
