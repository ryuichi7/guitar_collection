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
		@message = session[:message]
		if !logged_in?
			erb :'users/login'
		else
			redirect '/users/show'
		end
	end

	get '/signup' do
		@message = session[:message]
		if !logged_in?
			erb :'users/signup'
		else
			redirect '/users'
		end
	end

	post '/signup' do
		@user = User.new(params)
		if @user.save
			session[:id] = @user.id
			redirect '/users/show'
		else
			session[:message] = @user.errors.full_messages.to_sentence
			redirect '/signup'
		end
	end

	post '/login' do 
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/users/show'
		else
			session[:message] = "Incorrect username or password"
			redirect '/login'
		end
	end

	get '/logout' do
		session.clear
		session[:message] = "Successfully logged out"
		redirect '/login'
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
			if @user == current_user
				redirect '/users/show'
			else
				erb :'users/member'
			end
		else
			login_failure
		end
	end







end
