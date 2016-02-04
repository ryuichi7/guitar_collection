class PedalsController < ApplicationController

	get '/pedals' do
		if logged_in?
			@users = User.all
			erb :'pedals/index'
		else
			login_failure
		end
	end

	get '/pedals/new' do
		if logged_in?
			erb :'pedals/new'
		else
			login_failure
		end
	end

	post '/pedals' do
		if current_user.pedals.create(params).save
			redirect '/users/show'
		else
			@error = "Please fill in all fields"
			erb :'pedals/new'
		end
	end

	get '/pedals/:id/edit' do
		if logged_in?
			@pedal = Pedal.find_by_id(params[:id])
			erb :'pedals/edit'
		else
			login_failure
		end
	end

	delete '/pedals/:id/delete' do
		@pedal = Pedal.find_by_id(params[:id])
		@pedal.destroy if @pedal.user_id == current_user.id
		@error = 'Pedal successfully deleted'
		erb :'/users/show'
	end

	patch '/pedals/:id' do
		@pedal = Pedal.find_by_id(params[:id])
		if @pedal.update(params[:pedal])
			redirect '/pedals'
		else
			@error = "Please fill in all fields"
			erb :"pedals/edit"
		end
	end

	get '/pedals/:id' do
		if logged_in?
			@pedal = Pedal.find_by_id(params[:id])
			erb :'pedals/show'
		else
			login_failure
		end
	end
end