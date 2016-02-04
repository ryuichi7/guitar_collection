class UsersController < ApplicationController

	get '/users' do
		if logged_in?
	  	@users = User.all
			erb :'users/index'
		else
			login_failure
		end
	end

	get '/login' do
		if !logged_in?
			erb :'users/login'
		else
			redirect '/users/show'
		end
	end

	get '/signup' do
		@errors = params[:errors]
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
			redirect '/users/show'
		else
			redirect '/signup' #figure out how to add some error messages
		end
	end

	post '/login' do 
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/users/show'
		else
			redirect '/login' #figure eror message for login failure
		end
	end

	get '/logout' do
		session.clear
		redirect '/login' #some type of logout message
	end

	get '/users/show' do
		if logged_in?
			erb :'users/show'
		else
			login_failure
		end
	end

	get '/users/:id' do
		@user = User.find_by_id(params[:id])
		if logged_in?
			redirect '/users/show'
		else
			login_failure
		end
	end







end
