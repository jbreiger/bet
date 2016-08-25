class SessionsController < ApplicationController
	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/bets/create'
		else
			flash[:error] = 'Login info wrong!'
			redirect_to '/'
		end
	end

	def destroy
		session[:user_id] = nil
	    redirect_to '/'
	end
end
