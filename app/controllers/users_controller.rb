class UsersController < ApplicationController
  def new
  end

  def create
  	user = User.new(name: params[:name], birthdate: params[:birthdate], username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], money: 1000)
    if user.save
		flash[:message] = 'You signed up!'
		redirect_to '/'
    else
    	flash[:error] = 'Need Registration info!'
		redirect_to '/'
    end
  end

  def index
    redirect_to "/teams"
  end

  def edit
  	@user = User.find(session[:user_id])
  end

  def update
    current_user = User.find(session[:user_id])
    #puts current_user.id
    #puts "*****************"
    current_user.update(name: params[:name])
  	# current_user.update(name: params[:name], birthdate: params[:birthdate], username: params[:username], email: params[:email])
  	flash[:message] = "Profile has been updated!"
    redirect_to '/users/edit'
  end
end
