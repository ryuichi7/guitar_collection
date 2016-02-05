class GuitarsController < ApplicationController

	get '/guitars' do
		@message = session[:message]
		if logged_in?
			@users = User.all
			erb :'guitars/index'
		else
			login_failure
		end
	end

	get '/guitars/new' do
		if logged_in?
			erb :'guitars/new'
		else
			login_failure
		end
	end

	post '/guitars' do
		if current_user.guitars.create(params).save
			session[:message] = 'Guitar successfully created'
			redirect '/guitars'
		else
			@message = "Please fill in all fields"
			erb :'guitars/new'
		end
	end

	get '/guitars/:id/edit' do
		if logged_in?
			@guitar = Guitar.find_by_id(params[:id])
			erb :'guitars/edit'
		else
			login_failure
		end
	end

	delete '/guitars/:id/delete' do
		@guitar = Guitar.find_by_id(params[:id])
		@guitar.destroy if @guitar.user_id == current_user.id
		@message = 'Guitar successfully deleted'
		erb :'/users/show'
	end

	patch '/guitars/:id' do
		@guitar = Guitar.find_by_id(params[:id])
		if @guitar.update(params[:guitar]) && @guitar.user_id == current_user.id
			update_message
			redirect '/guitars'
		else
			@message = "Please fill in all fields"
			erb :"guitars/edit"
		end
	end

	get '/guitars/:id' do
		if logged_in?
			@guitar = Guitar.find_by_id(params[:id])
			erb :'guitars/show'
		else
			login_failure
		end
	end







end