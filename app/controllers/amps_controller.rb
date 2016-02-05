class AmpsController < ApplicationController

	get '/amps' do
		@message = session[:message]
		if logged_in?
			@users = User.all
			erb :'amps/index'
		else
			login_failure
		end
	end

	get '/amps/new' do
		if logged_in?
			erb :'amps/new'
		else
			login_failure
		end
	end

	post '/amps' do
		if current_user.amps.create(params).save
			redirect '/users/show'
		else
			@message = "Please fill in all fields"
			erb :'amps/new'
		end
	end

	get '/amps/:id/edit' do
		if logged_in?
			@amp = Amp.find_by_id(params[:id])
			erb :'amps/edit'
		else
			login_failure
		end
	end

	delete '/amps/:id/delete' do
		@amp = Amp.find_by_id(params[:id])
		@amp.destroy if @amp.user_id == current_user.id
		@message = 'amp successfully deleted'
		erb :'/users/show'
	end

	patch '/amps/:id' do
		@amp = Amp.find_by_id(params[:id])
		if @amp.update(params[:amp]) && @amp.user_id == current_user.id
			update_message
			redirect '/amps'
		else
			@message = "Please fill in all fields"
			erb :"amps/edit"
		end
	end

	get '/amps/:id' do
		if logged_in?
			@amp = Amp.find_by_id(params[:id])
			erb :'amps/show'
		else
			login_failure
		end
	end
end