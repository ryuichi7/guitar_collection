class GuitarsController < ApplicationController

	get '/guitars' do
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
			redirect '/users/show'
		else
			@error = "Please fill in all fields"
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
		@error = 'Guitar successfully deleted'
		erb :'/users/show'
	end

	patch '/guitars/:id' do
		@guitar = Guitar.find_by_id(params[:id])
		if @guitar.update(params[:guitar])
			redirect '/guitars'
		else
			@error = "Please fill in all fields"
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